#!/usr/bin/env python
import argparse
from contextlib import contextmanager
import getpass
import subprocess
import sys
import time
import urllib.parse as parse
from typing import Iterator, Optional

try:
    PSQL_EXECUTABLE=subprocess.check_output("which psql", shell=True).decode("utf-8")[:-1]
except subprocess.CalledProcessError:
    print("psql executable not found")
    exit(1)

KEYCHAIN="postgres-passwords"


def get_password(account: str, service: str) -> Optional[str]:
    try:
        return parse.unquote(subprocess.check_output([
            "security",
            "find-generic-password",
            "-a",
            f"{account}",
            "-s",
            f"{service}",
            "-w",
            f"{KEYCHAIN}"],
        ).decode("utf-8")[:-1])
    except subprocess.CalledProcessError:
        return None


def create_password(account: str, service: str) -> str:
    password = getpass.getpass()

    subprocess.check_call([
            "security",
            "add-generic-password",
            "-a",
            f"{account}",
            "-s",
            f"{service}",
            "-w",
            f"{parse.quote(password)}",
            f"{KEYCHAIN}"],
    )

    return password


@contextmanager
def start_cloud_sql(instance: str, port: int) -> Iterator[None]:
    process = subprocess.Popen(args=[
        "cloud_sql_proxy",
        f"-instances={instance}=tcp:{port}",
    ])

    time.sleep(3)
    try:
        yield
    finally:
        process.kill()


def psql(user: str, password: str, port: int, database: str):
    subprocess.check_call([
        PSQL_EXECUTABLE,
        "-h",
        "localhost",
        "-p",
        str(port),
        "-U",
        user,
        database
    ],
        stderr=sys.stderr,
        stdin=sys.stdin,
        stdout=sys.stdout,
        env={
            "PGPASSWORD": password
        })


def parse_parameters() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description='''
Script to easily login to CloudSQL instances without having to call multiple
parameters or to have to put passwords in your shell history.
'''
    )

    parser.add_argument("instance")
    parser.add_argument("database")
    parser.add_argument("-u", "--user", default="postgres")
    parser.add_argument("-p", "--port", default=5432, type=int)

    return parser.parse_args()


if __name__ == "__main__":
    args = parse_parameters()

    with start_cloud_sql(args.instance, args.port):
        password = get_password(args.user, args.instance)
        if not password:
            print("Password not found for", args.instance)
            password = create_password(args.user, args.instance)

        try:
            psql(args.user, password, args.port, args.database)
        except KeyboardInterrupt:
            pass


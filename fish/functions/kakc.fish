function kakc --wraps=kak --description 'Kakoune client wrapper. Automatically creates a daemon if no server exists.'
    set root_path (git_repository_root)
    if test -n $root_path
        set server_name (basename $root_path)
    else
        set server_name (basename $PWD)
    end

    set socket_file (kak -l | grep $server_name)

    if test -n $socket_file
        kak -d -s $server_name
    end

    kak -c $server_name $argv
end    

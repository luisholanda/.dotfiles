self: super:
{
  bmono = import ./data/fonts/bmono self;
  # TODO: try remove self.xorg
  brave = import ./networking/browsers/brave (self // self.xorg);
}

class GunCategory < ActiveHash::Base
  self.data = [
    {id: 1, name: "古銃"},
    {id: 2, name: "現代銃"}
  ]
end

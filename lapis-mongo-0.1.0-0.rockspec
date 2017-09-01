package = "lapis-mongo"
version = "0.1.0-0"

source = {
  url = "https://github.com/CriztianiX/lapis-mongo"
}

description = {
  summary = "MongoDB support for Lapis Framework",
  homepage = "https://github.com/CriztianiX/lapis-mongo",
  maintainer = "Cristian Haunsen <cristianhaunsen@gmail.com>",
  license = "MIT"
}

dependencies = {
  "lua ~> 5.1",
  "lapis",
  "lua-resty-moongoo"
}

build = {
  type = "builtin",
  modules = {
    ["lapis.db.mongo"] = "lapis/db/mongo.lua",
    ["lapis.db.mongo.model"] = "lapis/db/mongo/model.lua",
    ["lapis.db.mongo.pagination"] = "lapis/db/mongo/pagination.lua",
  }
}

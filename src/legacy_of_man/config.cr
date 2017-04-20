require "json"

module LegacyOfMan
  class Config
    JSON.mapping(
      port: Int32,
      bind: String,
    )
  end
end

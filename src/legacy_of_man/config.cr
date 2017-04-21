require "json"

module LegacyOfMan
  class Config
    JSON.mapping(
      port: Int32,
      bind: String,
      db_user: String,
      db_ip: String,
      db_name: String,
    )
  end
end

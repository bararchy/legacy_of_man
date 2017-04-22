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

  class CharData
    JSON.mapping(
      firstime: Bool,
      level: Int32,
      items: Hash(String, Int32),      # Item name and ammount, for example {"fruit" => 15}
      skills: Hash(String, Int32),     # Skill and the skill's level, for example {"sneak_attack" => 2}
      equipment: Hash(String, String), # Items that are equipet, for example {"glass_shard" => "right_hand"}
      stats: Hash(String, Int32),      # for exmaple {"Intelegance" => 5}
    )
  end
end

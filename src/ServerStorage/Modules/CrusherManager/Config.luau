local Config = {
    DAMAGE_COOLDOWN = 5,
}
Config.OVERLAP_PARAMS = OverlapParams.new()
Config.OVERLAP_PARAMS.FilterType = Enum.RaycastFilterType.Include
Config.OVERLAP_PARAMS.CollisionGroup = "CharacterRootPart"

return Config
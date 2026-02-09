local Config = {
    DAMAGE_COOLDOWN = 5,
    STUN_DURATION = 1
}
Config.OVERLAP_PARAMS = OverlapParams.new()
Config.OVERLAP_PARAMS.FilterType = Enum.RaycastFilterType.Exclude
Config.OVERLAP_PARAMS.CollisionGroup = "Crusher"

return Config
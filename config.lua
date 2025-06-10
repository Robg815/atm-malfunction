Config = {}

-- Framework auto-detection
Config.Framework = "auto" -- "qbcore", "esx", "qbox", or "auto"

-- List of ATMs
Config.ATMs = {
    vector3(147.65, -1035.71, 29.34),
    vector3(-386.84, 6046.05, 31.5),
    vector3(1171.52, 2702.61, 38.18),
    vector3(-56.89, -1752.14, 29.42),
    vector3(-165.15, 232.76, 94.93),
}

-- Cash reward config
Config.Reward = {
    min = 150,
    max = 450
}

-- Inventory support
Config.Inventory = {
    type = "ox_inventory", -- "qb-inventory", "ox_inventory", "none"
    item = "cashbundle",
    amount = 1
}

-- Time between malfunction events
Config.GlobalCooldown = 600 -- seconds
Config.ATMReuseCooldown = 900 -- seconds

-- How close must a player be to an ATM to trigger
Config.TriggerDistance = 30.0

-- Interaction radius (target zone)
Config.InteractionDistance = 2.0

-- Target system auto-detect
Config.Target = "auto" -- "qb-target", "ox_target", "e-interact", or "auto"

-- PS-Dispatch integration
Config.Dispatch = {
    enabled = true,
    job = "police",
    title = "ATM Malfunction",
    message = "ATM malfunctioning, possibly dropping cash. Check it out."
}

-- PS-MDT integration
Config.MDT = {
    enabled = true,
    category = "ATM Malfunction",
    description = "ATM was reported dispensing unclaimed money. Investigate."
}

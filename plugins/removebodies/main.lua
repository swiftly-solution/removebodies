AgentsModelPath = {
    "characters/models/tm_jumpsuit/tm_jumpsuit_varianta.vmdl",
    "characters/models/tm_professional/tm_professional_varf5.vmdl",
    "characters/models/ctm_st6/ctm_st6_variantj.vmdl",
    "characters/models/ctm_st6/ctm_st6_variantl.vmdl",
    "characters/models/ctm_swat/ctm_swat_variante.vmdl",
    "characters/models/ctm_swat/ctm_swat_variantf.vmdl",
    "characters/models/ctm_swat/ctm_swat_variantg.vmdl",
    "characters/models/ctm_swat/ctm_swat_varianth.vmdl",
    "characters/models/ctm_swat/ctm_swat_varianti.vmdl",
    "characters/models/ctm_swat/ctm_swat_variantj.vmdl",
    "characters/models/tm_balkan/tm_balkan_variantk.vmdl",
    "characters/models/tm_professional/tm_professional_varf.vmdl",
    "characters/models/tm_professional/tm_professional_varg.vmdl",
    "characters/models/tm_professional/tm_professional_varh.vmdl",
    "characters/models/tm_professional/tm_professional_varj.vmdl",
    "characters/models/tm_professional/tm_professional_vari.vmdl",
    "characters/models/tm_professional/tm_professional_varf1.vmdl",
    "characters/models/tm_professional/tm_professional_varf2.vmdl",
    "characters/models/tm_professional/tm_professional_varf3.vmdl",
    "characters/models/tm_professional/tm_professional_varf4.vmdl",
    "characters/models/ctm_gendarmerie/ctm_gendarmerie_varianta.vmdl",
    "characters/models/ctm_gendarmerie/ctm_gendarmerie_variantb.vmdl",
    "characters/models/ctm_gendarmerie/ctm_gendarmerie_variantc.vmdl",
    "characters/models/ctm_gendarmerie/ctm_gendarmerie_variantd.vmdl",
    "characters/models/ctm_gendarmerie/ctm_gendarmerie_variante.vmdl",
    "characters/models/ctm_swat/ctm_swat_variantk.vmdl",
    "characters/models/ctm_diver/ctm_diver_varianta.vmdl",
    "characters/models/ctm_diver/ctm_diver_variantb.vmdl",
    "characters/models/ctm_diver/ctm_diver_variantc.vmdl",
    "characters/models/tm_jungle_raider/tm_jungle_raider_varianta.vmdl",
    "characters/models/tm_jungle_raider/tm_jungle_raider_variantb.vmdl",
    "characters/models/tm_jungle_raider/tm_jungle_raider_variantc.vmdl",
    "characters/models/tm_jungle_raider/tm_jungle_raider_variantd.vmdl",
    "characters/models/tm_jungle_raider/tm_jungle_raider_variante.vmdl",
    "characters/models/tm_jungle_raider/tm_jungle_raider_variantf.vmdl",
    "characters/models/tm_jungle_raider/tm_jungle_raider_variantb2.vmdl",
    "characters/models/tm_jungle_raider/tm_jungle_raider_variantf2.vmdl",
    "characters/models/tm_leet/tm_leet_variantg.vmdl",
    "characters/models/tm_leet/tm_leet_varianth.vmdl",
    "characters/models/tm_leet/tm_leet_varianti.vmdl",
    "characters/models/tm_leet/tm_leet_variantf.vmdl",
    "characters/models/tm_leet/tm_leet_variantj.vmdl",
    "characters/models/tm_phoenix/tm_phoenix_varianth.vmdl",
    "characters/models/tm_phoenix/tm_phoenix_variantf.vmdl",
    "characters/models/tm_phoenix/tm_phoenix_variantg.vmdl",
    "characters/models/tm_phoenix/tm_phoenix_varianti.vmdl",
    "characters/models/ctm_fbi/ctm_fbi_variantf.vmdl",
    "characters/models/ctm_fbi/ctm_fbi_variantg.vmdl",
    "characters/models/ctm_fbi/ctm_fbi_varianth.vmdl",
    "characters/models/ctm_fbi/ctm_fbi_variantb.vmdl",
    "characters/models/ctm_st6/ctm_st6_variantk.vmdl",
    "characters/models/ctm_st6/ctm_st6_variante.vmdl",
    "characters/models/ctm_st6/ctm_st6_variantg.vmdl",
    "characters/models/ctm_st6/ctm_st6_variantm.vmdl",
    "characters/models/ctm_st6/ctm_st6_varianti.vmdl",
    "characters/models/ctm_st6/ctm_st6_variantn.vmdl",
    "characters/models/tm_balkan/tm_balkan_variantf.vmdl",
    "characters/models/tm_balkan/tm_balkan_varianti.vmdl",
    "characters/models/tm_balkan/tm_balkan_variantg.vmdl",
    "characters/models/tm_balkan/tm_balkan_variantj.vmdl",
    "characters/models/tm_balkan/tm_balkan_varianth.vmdl",
    "characters/models/tm_balkan/tm_balkan_variantl.vmdl",
    "characters/models/ctm_sas/ctm_sas_variantf.vmdl",
    "characters/models/ctm_sas/ctm_sas_variantg.vmdl",
    "characters/models/ctm_sas/ctm_sas.vmdl",
    "characters/models/tm_phoenix/tm_phoenix.vmdl"
}

AddEventHandler("OnPluginStart", function ()
    for i=1,#AgentsModelPath do
        precacher:PrecacheModel(AgentsModelPath[i])
    end
end)

AddEventHandler("OnPlayerDeath", function (event)
    local playerid = event:GetInt("userid")
    local attackerid = event:GetInt("attacker")
    local player = GetPlayer(playerid)
    local attackerid = GetPlayer(attackerid)

    if not player then return end
    if playerid == nil or attackerid == nil then return end
    if playerid == attackerid then return end

    SetTimeout(500, function()
        if not player:CCSPlayerPawn():IsValid() then return end
        CBaseModelEntity(player:CCSPlayerPawn():ToPtr()).Render = Color(255,255,255,0)

        if player:CBaseEntity().TeamNum ~= player:GetVar("removebodies.team") then
            player:SetVar("removebodies.team", player:CBaseEntity().TeamNum)
        else
            local instance = player:CBaseEntity().CBodyComponent.SceneNode:GetSkeletonInstance()
            local modelentity = CBaseModelEntity(player:CBaseEntity():ToPtr())
            if instance:IsValid() then
                if instance.ModelState:IsValid() then
                    local model = instance.ModelState.ModelName
                    modelentity:SetModel("characters/models/tm_jumpsuit/tm_jumpsuit_varianta.vmdl")
                    NextTick(function()
                        modelentity:SetModel(model)
                    end)
                end
            end
        end
    end)
end)

AddEventHandler("OnPlayerSpawn", function (event)
    local playerid = event:GetInt("userid")
    local player = GetPlayer(playerid)

    if not player then return end

    SetTimeout(500, function ()
        if not player:CCSPlayerPawn():IsValid() then return end
        CBaseModelEntity(player:CCSPlayerPawn():ToPtr()).Render = Color(255,255,255,255)
    end)
end)

function GetPluginAuthor()
    return "Swiftly Solution"
end

function GetPluginVersion()
    return "1.0.0"
end

function GetPluginName()
    return "Remove Dead Bodies"
end

function GetPluginWebsite()
    return "https://github.com/swiftly-solution/removebodies"
end
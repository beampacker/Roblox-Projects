LPH_OBFUSCATED = false;
if not LPH_OBFUSCATED then
    LPH_CRASH = function(...) --[[ Line: 12 ]]
        return ...;
    end;
    LPH_NO_VIRTUALIZE = function(...) --[[ Line: 13 ]]
        return ...;
    end;
    LPH_JIT_MAX = function(...) --[[ Line: 14 ]]
        return ...;
    end;
end;
local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_TextChatService_0 = game:GetService("TextChatService");
local l_StarterGui_0 = game:GetService("StarterGui");
local l_HttpService_0 = game:GetService("HttpService");
local l_RunService_0 = game:GetService("RunService");
local _ = game:GetService("UserInputService");
local l_GuiService_0 = game:GetService("GuiService");
local l_Stats_0 = game:GetService("Stats");
local l_Remotes_0 = l_ReplicatedStorage_0:WaitForChild("Remotes");
local l_Values_0 = l_ReplicatedStorage_0:WaitForChild("Values");
local l_Modules_0 = l_ReplicatedStorage_0:WaitForChild("Modules");
local l_RaycastUtil_0 = require(l_Modules_0:WaitForChild("RaycastUtil"));
local l_ToolInfo_0 = require(l_Modules_0:WaitForChild("ToolInfo"));
local l_MouseRaycast_0 = l_RaycastUtil_0.MouseRaycast;
local v15 = {};
for v16, v17 in pairs(l_ToolInfo_0) do
    v15[v16] = v17;
end;
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_CurrentCamera_0 = workspace.CurrentCamera;
local l_PlayerScripts_0 = l_LocalPlayer_0:WaitForChild("PlayerScripts");
local v21 = nil;
local v22 = nil;
local v23 = nil;
local v24 = nil;
while true do
    v21 = l_PlayerScripts_0:FindFirstChild("FallenGuard");
    v22 = l_TextChatService_0:FindFirstChild("1");
    v23 = l_TextChatService_0:FindFirstChild("2");
    v24 = l_TextChatService_0:FindFirstChild("3");
    if not v21 or not v22 or not v23 or not v24 then
        task.wait();
    else
        break;
    end;
end;
local v25 = {};
local v26 = 0;
local v27 = nil;
local v28 = nil;
local v29 = nil;
local v30 = nil;
local v31 = nil;
local v32 = nil;
local function v36(v33) --[[ Line: 76 ]]
    local v34 = math.random(1, 3);
    if v34 == 1 then
        local l_Sky_0 = Instance.new("Sky");
        l_Sky_0.Name = v33;
        l_Sky_0._ = 0;
    elseif v34 == 2 then
        assert(false, v33);
    end;
    error(v33);
end;
local v37 = newproxy(true);
local v38 = getmetatable(v37);
local v39 = nil;
for v40, v41 in pairs({
    "le", 
    "lt", 
    "eq", 
    "tostring", 
    "pow", 
    "div", 
    "mul", 
    "sub", 
    "add", 
    "unm", 
    "concat", 
    "call", 
    "index", 
    "newindex"
}) do
    v38["__" .. v41] = function() --[[ Line: 92 ]]
        v39 = v40;
        if rawequal(v41, "tostring") then
            return "";
        else
            return;
        end;
    end;
end;
v38.__metatable = "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n";
local v136 = LPH_JIT_MAX(function(_, ...) --[[ Line: 101 ]]
    local v43 = {
        ...
    };
    local v44 = false;
    if pcall(settings) then
        v43 = {
            0
        };
        v44 = true;
    elseif v39 then
        l_StarterGui_0:SetAttribute("r", l_HttpService_0:JSONEncode({
            v39
        }));
        v39 = false;
        v44 = true;
    else
        local v45 = getfenv(0);
        local v46 = getfenv(1);
        if rawequal(v45.script, v46.script) then
            v43 = {
                1
            };
            v44 = true;
        elseif os.clock() - v26 >= 10 then
            v26 = os.clock();
            local v47 = v31 == nil;
            v31 = v47 and 0 or v31 >= 5 and 1 or v31 + 1;
            if v31 == 1 or v47 then
                local v48 = getfenv();
                for v49, _ in pairs(v48._G) do
                    l_StarterGui_0:SetAttribute("s", l_HttpService_0:JSONEncode({
                        v49
                    }));
                    v44 = true;
                    break;
                end;
                for v51, _ in pairs(v48.shared) do
                    if not rawequal(v51, "ActiveBenches") and not rawequal(v51, "Beds") and not rawequal(v51, "LastTextBoxFocused") and not rawequal(v51, "LastJukebox") and not rawequal(v51, "cachedTeamModels") and not rawequal(v51, "ClanInfo") then
                        l_StarterGui_0:SetAttribute("s", l_HttpService_0:JSONEncode({
                            v51
                        }));
                        v44 = true;
                        break;
                    end;
                end;
                if not v27 or not v27.Parent then
                    local l_Character_0 = l_LocalPlayer_0.Character;
                    if l_Character_0 then
                        v27 = l_Character_0:FindFirstChildOfClass("Humanoid");
                    end;
                end;
                if v27 and v27.Parent then
                    local v54 = "q";
                    do
                        local l_v54_0 = v54;
                        local l_status_0, l_result_0 = pcall(function() --[[ Line: 146 ]]
                            l_v54_0 = v27[v37];
                        end);
                        if l_status_0 or l_v54_0 ~= "q" or not l_result_0:find("VectorUtil") or not l_result_0:find("invalid argument #2") or not l_result_0:find("string expected, got userdata") then
                            l_StarterGui_0:SetAttribute("a", l_HttpService_0:JSONEncode({
                                l_result_0
                            }));
                            v44 = true;
                        end;
                    end;
                end;
            end;
            if v31 == 2 or v47 then
                local l_Texture_0 = Instance.new("Texture");
                l_Texture_0.Name = "Humanoid";
                l_Texture_0.Parent = game.Lighting;
                for v59, v60 in pairs({
                    "WalkSpeed", 
                    "JumpHeight", 
                    "HipHeight"
                }) do
                    local v61 = "q";
                    local l_l_Texture_0_0 = l_Texture_0 --[[ copy: 6 -> 18 ]];
                    local l_status_1, l_result_1 = pcall(function() --[[ Line: 162 ]]
                        v61 = l_l_Texture_0_0[v60];
                    end);
                    if l_Texture_0.ClassName ~= "Texture" or l_status_1 or v61 ~= "q" or l_result_1:find("VectorUtil") or not l_result_1:find(v60) or not l_result_1:find("is not a valid member of") or not l_result_1:find("Texture") or not l_result_1:find("Lighting.Humanoid") then
                        l_StarterGui_0:SetAttribute("b", l_HttpService_0:JSONEncode({
                            l_result_1, 
                            v59
                        }));
                        v44 = true;
                        --[[ close >= 13 ]]
                        break;
                    else
                        local l_l_Texture_0_1 = l_Texture_0 --[[ copy: 6 -> 19 ]];
                        local l_status_2, l_result_2 = pcall(function() --[[ Line: 170 ]]
                            l_l_Texture_0_1[v60] = 0;
                        end);
                        if l_status_2 or l_result_2:find("VectorUtil") or not l_result_2:find(v60) or not l_result_2:find("is not a valid member of") or not l_result_2:find("Texture") or not l_result_2:find("Lighting.Humanoid") then
                            l_StarterGui_0:SetAttribute("c", l_HttpService_0:JSONEncode({
                                l_result_2, 
                                v59
                            }));
                            v44 = true;
                            --[[ close >= 13 ]]
                            break;
                        else
                            --[[ close >= 13 ]]
                        end;
                    end;
                end;
                local l_l_Texture_0_2 = l_Texture_0 --[[ copy: 6 -> 20 ]];
                local l_status_3, l_result_3 = pcall(function() --[[ Line: 179 ]]
                    l_l_Texture_0_2:FireServer();
                    return true;
                end);
                if l_status_3 or type(l_result_3) ~= "string" or l_result_3:find("VectorUtil") or not l_result_3:find("FireServer") or not l_result_3:find("is not a valid member of") or not l_result_3:find("Texture") or not l_result_3:find("Lighting.Humanoid") then
                    l_StarterGui_0:SetAttribute("d", l_HttpService_0:JSONEncode({
                        l_result_3
                    }));
                    v44 = true;
                end;
                l_Texture_0:Destroy();
            end;
            if v31 == 3 or v47 then
                local v90, v91 = xpcall(function() --[[ Line: 190 ]]
                    return game.WalkSpeed;
                end, LPH_JIT_MAX(function() --[[ Line: 192 ]]
                    local v71, v72, v73 = debug.info(2, "slf");
                    if not v28 then
                        v28 = v73;
                    end;
                    local v74 = v73 ~= v28;
                    local v75 = type(v73);
                    if v71 ~= "[C]" or v72 ~= -1 or v74 or v75 ~= "function" then
                        l_StarterGui_0:SetAttribute("e", l_HttpService_0:JSONEncode({
                            v74 and "true" or "false", 
                            v71, 
                            v72, 
                            v75
                        }));
                        v44 = true;
                        return;
                    else
                        local v76 = "q";
                        local l_status_4, l_result_4 = pcall(function() --[[ Line: 205 ]]
                            v76 = v73();
                        end);
                        if l_status_4 or v76 ~= "q" or not l_result_4:find("VectorUtil") or not l_result_4:find("missing argument #1") or not l_result_4:find("Instance expected)") then
                            l_StarterGui_0:SetAttribute("f", l_HttpService_0:JSONEncode({
                                l_result_4 or "N/A", 
                                1
                            }));
                            v44 = true;
                            return;
                        else
                            local l_status_5, l_result_5 = pcall(function() --[[ Line: 213 ]]
                                v76 = v73(game);
                            end);
                            if l_status_5 or v76 ~= "q" or not l_result_5:find("VectorUtil") or not l_result_5:find("missing argument #2") or not l_result_5:find("string expected)") then
                                l_StarterGui_0:SetAttribute("f", l_HttpService_0:JSONEncode({
                                    l_result_5 or "N/A", 
                                    2
                                }));
                                v44 = true;
                                return;
                            else
                                local l_status_6, l_result_6 = pcall(function() --[[ Line: 221 ]]
                                    v76 = v73(nil, "Parent");
                                end);
                                if l_status_6 or v76 ~= "q" or not l_result_6:find("VectorUtil") or not l_result_6:find("invalid argument #1") or not l_result_6:find("Instance expected, got nil") then
                                    l_StarterGui_0:SetAttribute("f", l_HttpService_0:JSONEncode({
                                        l_result_6 or "N/A", 
                                        3
                                    }));
                                    v44 = true;
                                    return;
                                else
                                    local v83 = nil;
                                    local l_status_7, l_result_7 = pcall(function() --[[ Line: 230 ]]
                                        local v84, v85 = v73(game.Lighting, "TimeOfDay", v37);
                                        v76 = v84;
                                        v83 = v85;
                                    end);
                                    if not l_status_7 or v76 == "q" or l_result_7 or type(v76) ~= "string" or v83 ~= nil then
                                        l_StarterGui_0:SetAttribute("f", l_HttpService_0:JSONEncode({
                                            l_result_7 or "N/A", 
                                            4
                                        }));
                                        v44 = true;
                                        return;
                                    else
                                        local v88, v89 = debug.info(2, "a");
                                        if v88 ~= 0 or not v89 then
                                            l_StarterGui_0:SetAttribute("g", l_HttpService_0:JSONEncode({
                                                v88, 
                                                v89 and "true" or "false"
                                            }));
                                            v44 = true;
                                        end;
                                        return;
                                    end;
                                end;
                            end;
                        end;
                    end;
                end));
                if v90 or v91 ~= nil then
                    l_StarterGui_0:SetAttribute("h", l_HttpService_0:JSONEncode({
                        2
                    }));
                    v44 = true;
                end;
            end;
            if v31 == 4 or v47 then
                local v112, v113 = xpcall(function() --[[ Line: 250 ]]
                    return game:FireServer();
                end, LPH_JIT_MAX(function() --[[ Line: 252 ]]
                    local v92, v93, v94 = debug.info(2, "slf");
                    if not v29 then
                        v29 = v94;
                    end;
                    local v95 = v94 ~= v29;
                    local v96 = type(v94);
                    if v92 ~= "[C]" or v93 ~= -1 or v95 or v96 ~= "function" then
                        l_StarterGui_0:SetAttribute("i", l_HttpService_0:JSONEncode({
                            v95 and "true" or "false", 
                            v92, 
                            v93, 
                            v96
                        }));
                        v44 = true;
                        return;
                    else
                        local l_status_8, l_result_8 = pcall(function() --[[ Line: 271 ]]
                            v94();
                            return true;
                        end);
                        local l_status_9, l_result_9 = pcall(function() --[[ Line: 275 ]]
                            if LPH_OBFUSCATED then
                                v94(l_ReplicatedStorage_0.LoadingScreen, "FireServer", v37);
                                return;
                            else
                                v94(l_ReplicatedStorage_0.LoadingScreen, v37);
                                return;
                            end;
                        end);
                        if not l_status_9 or l_result_9 ~= nil then
                            l_StarterGui_0:SetAttribute("j", l_HttpService_0:JSONEncode({
                                l_result_9 or "N/A", 
                                5
                            }));
                            v44 = true;
                            return;
                        elseif l_status_8 or type(l_result_8) ~= "string" or not l_result_8:find("VectorUtil") or not l_result_8:find("missing argument #1") or not l_result_8:find("Instance expected)", 1, true) then
                            l_StarterGui_0:SetAttribute("j", l_HttpService_0:JSONEncode({
                                l_result_8 or "N/A", 
                                1
                            }));
                            v44 = true;
                            return;
                        else
                            local l_l_Remotes_0_FirstChildWhichIsA_0 = l_Remotes_0:FindFirstChildWhichIsA("RemoteEvent", true);
                            local l_status_10, l_result_10 = pcall(function() --[[ Line: 293 ]]
                                v94(l_l_Remotes_0_FirstChildWhichIsA_0);
                                return true;
                            end);
                            if LPH_OBFUSCATED then
                                if l_status_10 or type(l_result_10) ~= "string" or not l_result_10:find("VectorUtil") or not l_result_10:find("missing argument #2") or not l_result_10:find("string expected)", 1, true) then
                                    l_StarterGui_0:SetAttribute("j", l_HttpService_0:JSONEncode({
                                        l_result_10 or "N/A", 
                                        2
                                    }));
                                    v44 = true;
                                    return;
                                end;
                            elseif l_status_10 or type(l_result_10) ~= "string" or not rawequal(l_result_10, "Argument 1 missing or nil") then
                                l_StarterGui_0:SetAttribute("j", l_HttpService_0:JSONEncode({
                                    l_result_10 or "N/A", 
                                    2
                                }));
                                v44 = true;
                                return;
                            end;
                            local l_status_11, l_result_11 = pcall(function() --[[ Line: 310 ]]
                                v94(v37, "FireServer");
                            end);
                            if l_status_11 or type(l_result_11) ~= "string" or not l_result_11:find("VectorUtil") or not l_result_11:find("invalid argument #1") or not l_result_11:find("Instance expected, got userdata") then
                                l_StarterGui_0:SetAttribute("j", l_HttpService_0:JSONEncode({
                                    l_result_11 or "N/A", 
                                    3
                                }));
                                v44 = true;
                                return;
                            else
                                local v106, v107 = debug.info(2, "a");
                                if v106 ~= 0 or not v107 then
                                    l_StarterGui_0:SetAttribute("k", l_HttpService_0:JSONEncode({
                                        v106, 
                                        v107 and "true" or "false"
                                    }));
                                    v44 = true;
                                    return;
                                else
                                    local _, l_result_12 = pcall(getfenv, 5);
                                    local _, l_result_13 = pcall(getfenv, 6);
                                    if type(l_result_12) ~= "table" or type(l_result_13) ~= "table" or getfenv(5).script ~= script or getfenv(6).script ~= script then
                                        l_StarterGui_0:SetAttribute("l", l_HttpService_0:JSONEncode({}));
                                        v44 = true;
                                    end;
                                    return;
                                end;
                            end;
                        end;
                    end;
                end));
                if v112 or v113 ~= nil then
                    l_StarterGui_0:SetAttribute("h", l_HttpService_0:JSONEncode({
                        3
                    }));
                    v44 = true;
                end;
            end;
            if v31 == 5 or v47 then
                local v132, v133 = xpcall(function() --[[ Line: 353 ]]
                    game.WalkSpeed = 0;
                    return true;
                end, LPH_JIT_MAX(function() --[[ Line: 356 ]]
                    local v114, v115, v116 = debug.info(2, "slf");
                    if not v30 then
                        v30 = v116;
                    end;
                    local v117 = v116 ~= v30;
                    local v118 = type(v116);
                    if v114 ~= "[C]" or v115 ~= -1 or v117 or v118 ~= "function" then
                        l_StarterGui_0:SetAttribute("t", l_HttpService_0:JSONEncode({
                            v117 and "true" or "false", 
                            v114, 
                            v115, 
                            v118
                        }));
                        v44 = true;
                        return;
                    else
                        local l_status_14, l_result_14 = pcall(function() --[[ Line: 371 ]]
                            v116();
                            return true;
                        end);
                        if l_status_14 or type(l_result_14) ~= "string" or not l_result_14:find("VectorUtil") or not l_result_14:find("missing argument #1") or not l_result_14:find("Instance expected)", 1, true) then
                            l_StarterGui_0:SetAttribute("t", l_HttpService_0:JSONEncode({
                                l_result_14 or "N/A", 
                                1
                            }));
                            v44 = true;
                            return;
                        else
                            local l_status_15, l_result_15 = pcall(function() --[[ Line: 380 ]]
                                v116(game);
                                return true;
                            end);
                            if l_status_15 or type(l_result_15) ~= "string" or not l_result_15:find("VectorUtil") or not l_result_15:find("missing argument #2") or not l_result_15:find("string expected)", 1, true) then
                                l_StarterGui_0:SetAttribute("t", l_HttpService_0:JSONEncode({
                                    l_result_15 or "N/A", 
                                    2
                                }));
                                v44 = true;
                                return;
                            else
                                local l_status_16, l_result_16 = pcall(function() --[[ Line: 389 ]]
                                    v116(v37);
                                    return true;
                                end);
                                if l_status_16 or type(l_result_16) ~= "string" or not l_result_16:find("VectorUtil") or not l_result_16:find("invalid argument #1") or not l_result_16:find("Instance expected, got userdata") then
                                    l_StarterGui_0:SetAttribute("t", l_HttpService_0:JSONEncode({
                                        l_result_16 or "N/A", 
                                        3
                                    }));
                                    v44 = true;
                                    return;
                                else
                                    local l_status_17, l_result_17 = pcall(function() --[[ Line: 398 ]]
                                        v116(nil, "WalkSpeed", 17);
                                        return true;
                                    end);
                                    if l_status_17 or type(l_result_17) ~= "string" or not l_result_17:find("VectorUtil") or not l_result_17:find("invalid argument #1") or not l_result_17:find("Instance expected, got nil") then
                                        l_StarterGui_0:SetAttribute("t", l_HttpService_0:JSONEncode({
                                            l_result_17 or "N/A", 
                                            4
                                        }));
                                        v44 = true;
                                        return;
                                    else
                                        local v127 = nil;
                                        local l_status_18, l_result_18 = pcall(function() --[[ Line: 408 ]]
                                            v127 = v116(workspace, "Name", "Workspace ", v37);
                                        end);
                                        if not l_status_18 or v127 ~= nil or l_result_18 ~= nil or workspace.Name ~= "Workspace " then
                                            l_StarterGui_0:SetAttribute("t", l_HttpService_0:JSONEncode({
                                                l_result_18 or "N/A", 
                                                5
                                            }));
                                            v44 = true;
                                            return;
                                        else
                                            local v130, v131 = debug.info(2, "a");
                                            if v130 ~= 0 or not v131 then
                                                l_StarterGui_0:SetAttribute("u", l_HttpService_0:JSONEncode({
                                                    v130, 
                                                    v131 and "true" or "false"
                                                }));
                                                v44 = true;
                                                return;
                                            else
                                                return;
                                            end;
                                        end;
                                    end;
                                end;
                            end;
                        end;
                    end;
                end));
                if v132 or v133 ~= nil then
                    l_StarterGui_0:SetAttribute("h", l_HttpService_0:JSONEncode({
                        1
                    }));
                    v44 = true;
                    return;
                end;
            end;
        end;
    end;
    if not v43[4] then
        v24:Fire(unpack(v43));
        v21:SendMessage("__" .. game.PlaceVersion, unpack(v43));
        if v44 then
            LPH_CRASH();
        end;
        return;
    else
        local l_status_19, l_result_19 = pcall(function() --[[ Line: 442 ]]
            return {
                v22:Invoke(unpack(v43))
            };
        end);
        if l_status_19 and l_result_19[1] ~= "-/|" then
            if LPH_OBFUSCATED then
                LPH_CRASH();
            else
                warn("ANTICHEAT REMOTEFUNCTION FAILED TO RETURN ARGUMENTS PROPERLY; IF OBFUSCATED, FallenGuard WOULD'VE CRASHED", v43, l_result_19);
            end;
        elseif v44 then
            LPH_CRASH();
        end;
        return unpack(type(l_result_19) == "table" and l_result_19 or {}, 2);
    end;
end);
local v137 = pcall(function() --[[ Line: 458 ]]
    collectgarbage("count");
end);
local v138 = 4;
local v139 = 0;
local v140 = 0;
local v164 = task.defer(LPH_JIT_MAX(function() --[[ Line: 464 ]]
    while l_Values_0.Loading.Value do
        task.wait(0.1);
        v138 = v138 + 1;
    end;
    local v141 = tick();
    repeat
        task.wait(0.1);
        v138 = v138 + 1;
    until game:IsLoaded() or tick() - v141 >= 45;
    task.wait(2);
    local v142 = {};
    local v143 = 19000.5;
    if not v137 then
        warn("collectgarbage() errored. Check if it has been fully deprecated?");
    end;
    local v144 = 0;
    local v145 = 0;
    local l_huge_0 = math.huge;
    local v147 = 0;
    local v148 = 0;
    local v149 = 0;
    local v150 = 0;
    v141 = tick();
    while l_RunService_0.RenderStepped:Wait() do
        local v151 = nil;
        local v152 = gcinfo();
        if v137 then
            v151 = collectgarbage("count");
            if math.abs(v151 - v152) > 0 then
                v149 = v149 + 1;
                if v149 >= 10 then
                    l_StarterGui_0:SetAttribute("m", l_HttpService_0:JSONEncode({
                        v152, 
                        v151
                    }));
                    break;
                end;
            else
                v149 = 0;
            end;
        end;
        local v153 = math.max(v152, v137 and v151 or 0);
        if math.abs(v153 - v144) <= 2 then
            l_huge_0 = math.min(l_huge_0, v153);
            v147 = math.max(v147, v153);
            v145 = v145 + 1;
            if v145 >= 100 then
                l_StarterGui_0:SetAttribute("n", l_HttpService_0:JSONEncode({
                    v144, 
                    l_huge_0, 
                    v147
                }));
                break;
            elseif v145 < 75 then

            end;
        else
            v145 = 0;
            l_huge_0 = math.huge;
            v147 = 0;
            v144 = v153;
        end;
        if tick() - v150 >= 0.5 then
            v150 = tick();
            local v154 = gcinfo();
            local v155 = {};
            table.insert(v155, {
                {
                    {}
                }
            });
            for v156 = 1, 100 do
                table.insert(v155[1][1], math.random(1, 100) * math.sin(v156));
            end;
            table.remove(v155[1], 1);
            table.remove(v155, 1);
            v148 = math.abs(gcinfo() - v154) == 0 and v148 + 1 or 0;
            if v148 >= 30 then
                l_StarterGui_0:SetAttribute("o", l_HttpService_0:JSONEncode({}));
                break;
            elseif v148 >= 15 then

            end;
        end;
        task.wait(0.1);
        local v157 = math.max(gcinfo(), v137 and collectgarbage("count") or 0) - v153;
        if v142 and v157 > 2 and tick() - v141 >= 15 then
            table.insert(v142, v157);
            local v158 = 0;
            for _, v160 in pairs(v142) do
                v158 = v158 + v160;
            end;
        end;
        if v142 and #v142 >= 50 then
            local v161 = 0;
            for _, v163 in pairs(v142) do
                v161 = v161 + v163;
            end;
            v143 = math.clamp(math.ceil(v161 / #v142 * 15), 15000, 20000);
            v142 = nil;
        end;
        if v143 * 0.5 <= v157 then

        end;
        if v143 < v157 then
            l_StarterGui_0:SetAttribute("q", l_HttpService_0:JSONEncode({
                v157, 
                v143
            }));
            break;
        else
            v138 = v138 + 1;
        end;
    end;
    LPH_CRASH();
end));
local v165 = {};
local v168 = LPH_NO_VIRTUALIZE(function() --[[ Line: 630 ]]
    local v166 = setmetatable({
        {}
    }, {
        __mode = "kv"
    });
    local _ = nil;
    repeat
        v165 = {
            rawlen(v166), 
            table.maxn(v166)
        };
        wait(0.11);
    until rawlen(v166) == 0 or not rawget(v166, 1) or table.maxn(v166) == 0;
end);
local v169 = nil;
local v170 = nil;
local v171 = nil;
local v172 = os.clock();
local function v281(_, v174, v175, v176) --[[ Line: 647 ]]
    local v177 = v25[v174];
    if not v177 then
        v177 = {};
        v25[v174] = v177;
    end;
    local v178 = v177[v175];
    if v178 then
        v178:Destroy();
    end;
    v178 = Instance.new("BindableEvent");
    v178.Event:Connect(v176);
    v177[v175] = v178;
    v23:Fire(v174, v175, v178);
    if v175 ~= string.char(139, 69, 112, 34, 135, 187, 185, 110, 102, 27, 11, 71, 142, 94, 63, 149, 48, 11, 174, 74, 123, 167, 169, 90, 182, 183, 188, 116, 61, 158) then
        return;
    else
        local v179 = nil;
        xpcall(function() --[[ Line: 669 ]]
            return game.OHNOGG;
        end, function() --[[ Line: 671 ]]
            v179 = debug.info(2, "f");
        end);
        local v180 = {
            [1] = {
                function() --[[ Line: 675 ]]
                    return (rawequal());
                end, 
                "VectorUtil", 
                ": missing argument #1"
            }, 
            [2] = {
                function() --[[ Line: 676 ]]
                    return (rawequal("a"));
                end, 
                "VectorUtil", 
                ": missing argument #2"
            }, 
            [3] = {
                function() --[[ Line: 677 ]]
                    return (getmetatable());
                end, 
                "VectorUtil", 
                ": missing argument #1"
            }, 
            [4] = {
                function() --[[ Line: 678 ]]
                    return (setmetatable());
                end, 
                "VectorUtil", 
                ": missing argument #1 to", 
                "setmetatable", 
                "table expected"
            }, 
            [5] = {
                function() --[[ Line: 679 ]]
                    return (setmetatable(""));
                end, 
                "VectorUtil", 
                ": invalid argument #1 to", 
                "setmetatable", 
                "table expected, got string"
            }, 
            [6] = {
                function() --[[ Line: 680 ]]
                    return (setmetatable({}));
                end, 
                "VectorUtil", 
                ": missing argument #2 to", 
                "setmetatable", 
                "nil or table expected"
            }, 
            [7] = {
                function() --[[ Line: 681 ]]
                    return (setmetatable({}, ""));
                end, 
                "VectorUtil", 
                ": invalid argument #2 to", 
                "setmetatable", 
                "nil or table expected, got string"
            }, 
            [8] = {
                function() --[[ Line: 682 ]]
                    return task.spawn({});
                end, 
                "VectorUtil", 
                ": invalid argument #1 to", 
                "spawn", 
                "function or thread expected"
            }, 
            [9] = {
                function() --[[ Line: 683 ]]
                    return task.defer({});
                end, 
                "VectorUtil", 
                ": invalid argument #1 to", 
                "defer", 
                "function or thread expected"
            }, 
            [10] = {
                function() --[[ Line: 684 ]]
                    return task.delay();
                end, 
                "VectorUtil", 
                ": invalid argument #2 to", 
                "delay", 
                "function or thread expected"
            }, 
            [11] = {
                function() --[[ Line: 685 ]]
                    return task.delay({});
                end, 
                "VectorUtil", 
                ": invalid argument #1 to", 
                "delay", 
                "number expected, got table"
            }, 
            [12] = {
                function() --[[ Line: 686 ]]
                    return newproxy(v37);
                end, 
                "VectorUtil", 
                ": invalid argument #1 to", 
                "newproxy", 
                "nil or boolean expected, got userdata"
            }
        };
        local function v187(v181, v182) --[[ Line: 689 ]] --[[ Name: findin ]]
            local v183 = 0;
            for _, v185 in pairs(v182) do
                local v186 = string.find(v181, v185);
                if not v186 or v186 < v183 then
                    return false;
                else
                    v183 = v186;
                end;
            end;
            return true;
        end;
        local v188 = 0;
        local v189 = 0;
        local v254 = LPH_JIT_MAX(function() --[[ Line: 702 ]]
            local l_Character_1 = l_LocalPlayer_0.Character;
            l_Stats_0.Name = "Stats  ";
            local v191 = nil;
            local v192 = nil;
            local v193 = nil;
            local v194 = nil;
            if l_Character_1 then
                local l_Humanoid_0 = l_Character_1:FindFirstChildOfClass("Humanoid");
                l_Stats_0.Name = "Stats   ";
                if l_Humanoid_0 then
                    v191 = l_Humanoid_0.WalkSpeed;
                    v192 = l_Humanoid_0.JumpHeight;
                    v193 = l_Humanoid_0.HipHeight;
                end;
                l_Stats_0.Name = "Stats    ";
                local l_PrimaryPart_0 = l_Character_1.PrimaryPart;
                if l_PrimaryPart_0 then
                    v194 = l_PrimaryPart_0.CFrame;
                end;
                l_Stats_0.Name = "Stats     ";
                if l_Humanoid_0 then
                    local l_l_Humanoid_0_0 = l_Humanoid_0 --[[ copy: 5 -> 38 ]];
                    local l_status_20, l_result_20 = pcall(function() --[[ Line: 719 ]]
                        l_l_Humanoid_0_0[v37] = 0;
                    end);
                    if l_status_20 or not l_result_20:find("VectorUtil") or not l_result_20:find("invalid argument #2") or not l_result_20:find("string expected, got userdata") then
                        v36("HD_8 " .. (l_result_20 or "N/A") .. "0");
                    end;
                    local l_l_Humanoid_0_1 = l_Humanoid_0 --[[ copy: 5 -> 39 ]];
                    local l_status_21, l_result_21 = pcall(function() --[[ Line: 725 ]]
                        l_l_Humanoid_0_1.Parent = v37;
                    end);
                    if l_status_21 or not l_Humanoid_0.Parent or l_Humanoid_0.Parent ~= l_Character_1 or not l_result_21:find("VectorUtil") or not l_result_21:find("invalid argument #3") or not l_result_21:find("Instance expected, got userdata") then
                        v36("HD_9 " .. (l_result_21 or "N/A") .. l_Humanoid_0:GetFullName());
                    end;
                end;
            end;
            l_Stats_0.Name = "Stats      ";
            gcinfo();
            collectgarbage("count");
            math.random();
            l_Stats_0.Name = "Stats       ";
            local l_status_22, l_result_22 = pcall(function() --[[ Line: 738 ]]
                error("oh");
            end);
            if l_status_22 or not l_result_22:find("oh") then
                v36("HD_1");
            end;
            l_Stats_0.Name = "Stats        ";
            local v210, v211 = xpcall(function() --[[ Line: 743 ]]
                local _ = game._;
            end, function() --[[ Line: 743 ]]
                local v206, v207, v208 = debug.info(2, "slf");
                local v209 = false;
                if v206 == "[C]" then
                    v209 = false;
                    if v207 == -1 then
                        v209 = v208 == v179;
                    end;
                end;
                return v209;
            end);
            if v210 or v211 ~= true then
                v36("HD_2");
            end;
            l_Stats_0.Name = "Stats         ";
            local v212 = newproxy(true);
            if type(v212) ~= "userdata" or getmetatable(v212) == nil then
                v36("HD_3");
            end;
            if not restrictedFuncThread or type(restrictedFuncThread) ~= "thread" or os.clock() - v172 >= 480 or coroutine.status(restrictedFuncThread) ~= "running" and coroutine.status(restrictedFuncThread) ~= "suspended" then
                v36("NO.RESTR.." .. type(restrictedFuncThread) .. "/" .. math.ceil(os.clock() - v172) .. "/" .. coroutine.status(restrictedFuncThread));
            end;
            l_Stats_0.Name = "Stats          ";
            local v213 = getfenv();
            if type(v213) ~= "table" or v213.script ~= script then
                v36("HD_4");
            end;
            l_Stats_0.Name = "Stats           ";
            v188 = v188 + 1;
            if v188 >= 3 then
                for v214, v215 in pairs(v180) do
                    local l_status_23, l_result_23 = pcall(v215[1]);
                    if l_status_23 or type(l_result_23) ~= "string" or not v187(l_result_23, {
                        select(2, unpack(v215))
                    }) then
                        v36("HD_5 " .. (l_result_23 == nil and "N/A" or tostring(l_result_23)) .. v214);
                    end;
                end;
                v188 = 0;
            end;
            l_Stats_0.Name = "Stats            ";
            if coroutine.status(v164) ~= "running" and coroutine.status(v164) ~= "suspended" then
                v36("HD_6");
            elseif math.abs(v138 - v139) <= 1 then
                if not LPH_OBFUSCATED then

                end;
                v140 = v140 + 1;
                if v140 >= 9 then
                    v36("HD_7");
                end;
            else
                v140 = 0;
            end;
            v139 = v138;
            l_Stats_0.Name = "Stats             ";
            if v171 == nil then
                if l_MouseRaycast_0 ~= l_RaycastUtil_0.MouseRaycast then
                    v171 = "CH..1";
                else
                    local v223, v224 = xpcall(function() --[[ Line: 799 ]]
                        l_RaycastUtil_0.MouseRaycast(l_RaycastUtil_0, nil, nil, true);
                    end, function(v218) --[[ Line: 801 ]]
                        if type(v218) ~= "string" or not v218:find("RaycastUtil") or not v218:find("attempt to perform arithmetic") or not v218:find("Vector3") or not v218:find("boolean") then
                            return v218;
                        else
                            local v219, v220, v221, v222 = debug.info(3, "sna");
                            if v219 ~= "ReplicatedStorage.Modules.VectorUtil" or v220 ~= "" or v221 ~= 0 or v222 ~= false then
                                return tostring(v219) .. "/" .. tostring(v220) .. "/" .. tostring(v221) .. "/" .. tostring(v222);
                            else
                                return 0;
                            end;
                        end;
                    end);
                    if v223 or v224 ~= 0 then
                        v171 = "CH..2" .. tostring(v223) .. tostring(v224);
                    else
                        local v225 = {
                            l_RaycastUtil_0:MouseRaycast(nil, {}, 1)
                        };
                        if v225[5] ~= 1 or typeof(v225[1]) ~= "Vector3" or v225[2] ~= nil and typeof(v225[2]) ~= "Instance" or v225[3] ~= nil and typeof(v225[3]) ~= "Vector3" or v225[4] ~= nil and typeof(v225[4]) ~= "EnumItem" then
                            v171 = "CH..3" .. typeof(v225[1]) .. typeof(v225[2]) .. typeof(v225[3]) .. typeof(v225[4]) .. tostring(v225[5]);
                        end;
                    end;
                end;
            end;
            if v171 then
                v36(v171);
            end;
            local v226 = 0;
            local v227 = nil;
            if v170 == nil then
                if l_ToolInfo_0 ~= l_ToolInfo_0 then
                    v170 = "ToolInfo table doesn't match cached table";
                else
                    local v228 = {
                        ["Salvaged AK47"] = {
                            30, 
                            1.5, 
                            0.2, 
                            0, 
                            0, 
                            0.05, 
                            0.1, 
                            500, 
                            2300, 
                            0.5, 
                            16, 
                            0.2
                        }, 
                        ["Military M4A1"] = {
                            30, 
                            1.5, 
                            nil, 
                            0, 
                            0, 
                            0.05, 
                            0.1, 
                            600, 
                            2300, 
                            0.5, 
                            18, 
                            0.1
                        }, 
                        ["Salvaged AK74u"] = {
                            20, 
                            2, 
                            nil, 
                            0, 
                            0, 
                            0.05, 
                            0.1, 
                            600, 
                            2000, 
                            0.55, 
                            13, 
                            0.5
                        }, 
                        ["Salvaged Python"] = {
                            6, 
                            5, 
                            -0.1, 
                            0, 
                            0, 
                            0.05, 
                            0.1, 
                            320, 
                            2000, 
                            0.55, 
                            12, 
                            0.5
                        }, 
                        ["Salvaged M14"] = {
                            14, 
                            2.5, 
                            -0.1, 
                            0, 
                            0, 
                            0.05, 
                            0.1, 
                            400, 
                            2300, 
                            0.5, 
                            19, 
                            0.3
                        }, 
                        ["Military PKM"] = {
                            50, 
                            3, 
                            0.1, 
                            0, 
                            0, 
                            0.05, 
                            0.1, 
                            475, 
                            2600, 
                            0.5, 
                            22, 
                            0.1
                        }, 
                        ["Salvaged P250"] = {
                            8, 
                            1.5, 
                            -0.1, 
                            0, 
                            0, 
                            0.05, 
                            0.1, 
                            400, 
                            1700, 
                            0.55, 
                            15, 
                            1.5
                        }, 
                        ["Salvaged SMG"] = {
                            20, 
                            2, 
                            nil, 
                            0, 
                            0, 
                            0.05, 
                            0.1, 
                            500, 
                            2000, 
                            0.55, 
                            15, 
                            0.5, 
                            15, 
                            0.5
                        }, 
                        ["Salvaged Skorpion"] = {
                            15, 
                            2, 
                            0, 
                            0, 
                            0, 
                            0.05, 
                            0.1, 
                            625, 
                            1700, 
                            0.55, 
                            16, 
                            1.5
                        }, 
                        ["Military Barrett"] = {
                            5, 
                            7, 
                            -0.1, 
                            -1.75, 
                            0, 
                            0.07, 
                            0.15, 
                            175, 
                            2600, 
                            0.5, 
                            16, 
                            0.1
                        }, 
                        ["Military MP7"] = {
                            22, 
                            0.9, 
                            nil, 
                            0, 
                            0, 
                            0.05, 
                            0.1, 
                            575, 
                            2000, 
                            0.55, 
                            13, 
                            0.5
                        }
                    };
                    for v229, v230 in pairs(l_ToolInfo_0) do
                        if type(v229) ~= "string" or type(v230) ~= "table" then
                            v170 = "Non-table detected: " .. tostring(v229);
                            break;
                        elseif v15[v229] ~= v230 then
                            v170 = "ToolInfo for " .. v229 .. " doesn't match catched tool info";
                            break;
                        else
                            v226 = v226 + 1;
                            local l_Weapon_0 = v230.Weapon;
                            local v232 = v228[v229];
                            if l_Weapon_0 or v232 then
                                local l_Auto_0 = l_Weapon_0.Auto;
                                if l_Weapon_0.RPM or l_Weapon_0.UsePositionTimes then
                                    if type(l_Auto_0) ~= "boolean" then
                                        v170 = "Weapon.Auto was set to a non-boolean value: " .. v229 .. " = " .. tostring(l_Auto_0);
                                        break;
                                    elseif v227 == nil then
                                        v227 = l_Auto_0;
                                    elseif v227 ~= 0 and l_Auto_0 ~= v227 then
                                        v227 = 0;
                                    end;
                                elseif l_Auto_0 ~= nil then
                                    v170 = "Weapon.Auto found on a non-usable tool: " .. v229 .. " = " .. tostring(l_Auto_0);
                                    break;
                                end;
                                local l_Recoil_0 = v230.Recoil;
                                local l_Bullet_0 = v230.Bullet;
                                local l_Spread_0 = v230.Spread;
                                if l_Weapon_0.RPM then
                                    if type(l_Recoil_0) ~= "table" or type(l_Bullet_0) ~= "table" or type(l_Spread_0) ~= "table" then
                                        v170 = "Gun-only table deletion: " .. v229;
                                        break;
                                    else
                                        local l_Camera_0 = l_Recoil_0.Camera;
                                        if type(l_Camera_0) ~= "table" or type(l_Camera_0.RecoilStart) ~= "function" or type(l_Camera_0.RecoilFinish) ~= "function" then
                                            v170 = "Recoil table tampered: " .. v229;
                                            break;
                                        elseif l_Camera_0.FinishStart > l_Camera_0.Duration or v232 and (l_Camera_0.FinishStart < v232[6] or l_Camera_0.FinishStart > v232[7]) then
                                            v170 = "Recoil.FinishStart tampered: " .. v229 .. " = " .. l_Camera_0.FinishStart;
                                            break;
                                        elseif l_Spread_0.Hip.Hide ~= false and v229 ~= "Salvaged RPG" or l_Spread_0.Hip.Idle > l_Spread_0.Hip.Moving + 0.01 or l_Spread_0.Aiming and l_Spread_0.Aiming.Idle > l_Spread_0.Aiming.Moving + 0.01 then
                                            v170 = "gun spread tamper #1 " .. v229;
                                            break;
                                        else
                                            if v232 then
                                                local v238 = nil;
                                                local v239 = nil;
                                                if l_Weapon_0.RPM > v232[8] then
                                                    v238 = "Weapon.RPM";
                                                    v239 = l_Weapon_0.RPM;
                                                elseif l_Bullet_0.Speed > v232[9] then
                                                    v238 = "Bullet.Speed";
                                                    v239 = l_Bullet_0.Speed;
                                                elseif l_Bullet_0.Gravity < v232[10] then
                                                    v238 = "Bullet.Gravity";
                                                    v239 = l_Bullet_0.Gravity;
                                                elseif l_Spread_0.Hip.Idle < v232[11] or l_Spread_0.Hip.Moving < v232[11] then
                                                    v238 = "Hip.Spread";
                                                    v239 = l_Spread_0.Hip.Idle .. "/" .. l_Spread_0.Hip.Moving;
                                                elseif l_Spread_0.Aiming.Idle < v232[12] or l_Spread_0.Aiming.Moving < v232[12] then
                                                    v238 = "Aiming.Spread";
                                                    v239 = l_Spread_0.Aiming.Idle .. "/" .. l_Spread_0.Aiming.Moving;
                                                end;
                                                if v238 then
                                                    v170 = "gun spread tamper #2 " .. v229 .. " (" .. v238 .. " = " .. v239 .. ")";
                                                    break;
                                                end;
                                            end;
                                            for _, v241 in pairs({
                                                "RecoilStart", 
                                                "RecoilFinish"
                                            }) do
                                                local v247, v248 = xpcall(function() --[[ Line: 924 ]]
                                                    l_Camera_0[v241](math.random(1, 2) == 1);
                                                end, function(v242) --[[ Line: 926 ]]
                                                    if type(v242) ~= "string" or not v242:find("ReplicatedStorage.Modules.ToolInfo") or not v242:find("attempt to perform arithmetic") or not v242:find("boolean") or not v242:find("number") then
                                                        return v242;
                                                    else
                                                        local v243, v244, v245, v246 = debug.info(2, "sna");
                                                        if v243 ~= "ReplicatedStorage.Modules.ToolInfo" or v244 ~= v241 or v245 ~= 1 or v246 ~= false then
                                                            return tostring(v243) .. "/" .. tostring(v244) .. "/" .. tostring(v245) .. "/" .. tostring(v246);
                                                        else
                                                            return 0;
                                                        end;
                                                    end;
                                                end);
                                                if v247 or v248 ~= 0 then
                                                    v170 = v241 .. " function tampering #1 for " .. v229 .. ": " .. tostring(v247) .. " / " .. tostring(v248);
                                                    break;
                                                elseif v232 then
                                                    local v249 = math.random(1, v232[1]);
                                                    local v250, v251, v252 = pcall(function() --[[ Line: 956 ]]
                                                        return l_Camera_0[v241](v249);
                                                    end);
                                                    if not v250 or type(v251) ~= "number" or type(v252) ~= "number" then
                                                        v170 = ("%* function tampering #2 for %*: invalid return values %*"):format(v241, v229, v249);
                                                        break;
                                                    elseif v241 == "RecoilStart" and (v251 < v232[2] or v232[3] and v252 < v232[3]) then
                                                        v170 = ("%* function tampering #3 for %*: return values lower than cached lowest %* (Y: %*/%*) (X: %*/%*)"):format(v241, v229, v249, v251, v232[2], v252, v232[3]);
                                                        break;
                                                    elseif v241 == "RecoilFinish" then
                                                        local v253 = math.abs(l_Camera_0.Duration - l_Camera_0.FinishStart) <= 0.001;
                                                        if math.abs(v251 - v232[4]) > 0.01 or math.abs(v252 - v232[5]) > 0.01 then
                                                            v170 = v241 .. " function tampering #4 for " .. v229 .. ": return values unequal to cached " .. v249 .. " (Y: " .. v251 .. "/" .. v232[4] .. ") (X: " .. v252 .. "/" .. v232[5] .. ")";
                                                            break;
                                                        elseif v232[4] ~= 0 and v253 then
                                                            v170 = "recoil table tampering #1: " .. v229 .. " " .. v249;
                                                            break;
                                                        elseif v232[4] == 0 and not v253 then
                                                            v170 = "recoil table tampering #2: " .. v229 .. " " .. v249;
                                                            break;
                                                        end;
                                                    end;
                                                end;
                                            end;
                                        end;
                                    end;
                                elseif l_Recoil_0 ~= nil or l_Bullet_0 ~= nil then
                                    v170 = "Gun-only tables found on a non-gun tool: " .. v229;
                                    break;
                                end;
                            end;
                        end;
                    end;
                    if not v170 then
                        if v227 ~= 0 then
                            v170 = "All tools set to same Auto value: " .. tostring(v227);
                        elseif v226 < 48 then
                            v170 = "Total ToolInfo counts altered: " .. v226;
                        end;
                    end;
                end;
            end;
            if v170 then
                v36("CH4.." .. v170);
            end;
            l_Stats_0.Name = "Stats";
            return {
                v191, 
                v192, 
                v193, 
                v194
            };
        end);
        if v169 then
            task.cancel(v169);
        end;
        v169 = task.spawn(function() --[[ Line: 1006 ]]
            local v255 = {
                "ServerScriptService", 
                "CoreGui", 
                "MessageBusService", 
                "TimerService", 
                "VideoCaptureService", 
                "NotificationService", 
                "MaterialService", 
                "StarterPlayer", 
                "GeometryService", 
                "CookiesService", 
                "MouseService", 
                "SolidModelContentProvider", 
                "HSRDataContentProvider", 
                "MeshContentProvider", 
                "NetworkClient", 
                "AssetService", 
                "ServerStorage", 
                "StarterPack", 
                "JointsService", 
                "PhysicsService", 
                "InsertService", 
                "KeyboardService", 
                "MemStorageService", 
                "PermissionsService", 
                "VirtualInputManager", 
                "test", 
                "LogService", 
                "test2", 
                "TeleportService", 
                "ScriptService", 
                "Teams", 
                "AdService", 
                "SharedTableRegistry"
            };
            local _, l_result_27 = pcall(function() --[[ Line: 1053 ]]
                local v256 = nil;
                while true do
                    l_Stats_0.Name = "Stats ";
                    if game:IsLoaded() and not v32 then
                        v32 = os.clock();
                        task.defer(function() --[[ Line: 1060 ]]
                            local _, l_result_25 = pcall(function() --[[ Line: 1061 ]]
                                local v257 = setmetatable({}, {
                                    __mode = "v"
                                });
                                for _, v259 in pairs(v255) do
                                    local v260 = nil;
                                    v260 = if v259 == "test" then workspace:FindFirstChild("BenchSpawnGroups") else if v259 == "test2" then game:FindFirstChildWhichIsA("ClientReplicator") else game:GetService(v259);
                                    v257[#v257 + 1] = v260;
                                    v260 = nil;
                                end;
                                v168();
                                if rawlen(v257) ~= 0 or rawget(v257, 1) or table.maxn(v257) ~= 0 then
                                    task.wait(3);
                                end;
                                local v261 = table.maxn(v257);
                                local v262 = false;
                                for v263, v264 in pairs(v257) do
                                    if v264 ~= nil and v263 < rawlen(v255) - 2 then
                                        local _, l_result_24 = pcall(function() --[[ Line: 1083 ]]
                                            return v264:GetFullName();
                                        end);
                                        if v263 == 1 and rawlen(v257) == 32 and v261 == 32 and l_result_24 == "ServerScriptService" then
                                            v189 = v189 + 1;
                                            v262 = true;
                                            if v189 < 3 then
                                                break;
                                            end;
                                        end;
                                        l_StarterGui_0:SetAttribute("p", l_HttpService_0:JSONEncode({
                                            l_result_24, 
                                            v263 .. "/" .. rawlen(v257) .. "/" .. v261
                                        }));
                                        break;
                                    end;
                                end;
                                if not v262 then
                                    v189 = 0;
                                end;
                                v32 = nil;
                            end);
                            if l_result_25 then
                                v256 = l_result_25;
                            end;
                        end);
                    end;
                    if v256 then
                        v36(v256);
                    elseif v32 and os.clock() - v32 <= 60 then

                    end;
                    game:SetAttribute("1", (math.ceil((workspace:GetServerTimeNow()))));
                    local l_status_26, l_result_26 = pcall(v254);
                    local v271 = nil;
                    local v272 = nil;
                    local v273 = nil;
                    local v274 = nil;
                    if l_status_26 then
                        local v275, v276, v277, v278 = unpack(l_result_26);
                        v271 = v275;
                        v272 = v276;
                        v273 = v277;
                        v274 = v278;
                        l_result_26 = nil;
                    end;
                    if v21.Parent then
                        v21:SendMessage("_" .. game.JobId, v179, v271, v272, v273, l_Stats_0:GetTotalMemoryUsageMb(), workspace.Gravity, l_CurrentCamera_0.CFrame, v274, l_result_26);
                    end;
                    task.wait(5);
                end;
            end);
            game:SetAttribute("ass", l_result_27);
        end);
        return;
    end;
end;
restrictedFuncThread = coroutine.create(function() --[[ Line: 1133 ]]
    local v282 = nil;
    local v283 = nil;
    while true do
        v172 = os.clock();
        local v285 = {
            [1] = {
                function() --[[ Line: 1138 ]]
                    return game:GetService("HttpRbxApiService").PostAsync(l_HttpService_0);
                end, 
                "PostAsync"
            }, 
            [2] = {
                function() --[[ Line: 1141 ]]
                    return game:GetService("HttpRbxApiService").PostAsync(game.HttpRbxApiService, "https://economy.roblox.com/v1/user/currency", "", Enum.ThrottlingPriority.Default, Enum.HttpContentType.TextPlain, Enum.HttpRequestType.Default);
                end, 
                "PostAsync"
            }, 
            [3] = {
                function() --[[ Line: 1144 ]]
                    return game:GetService("HttpRbxApiService").PostAsyncFullUrl(workspace);
                end, 
                "PostAsyncFullUrl"
            }, 
            [4] = {
                function() --[[ Line: 1147 ]]
                    return game:GetService("HttpRbxApiService").PostAsyncFullUrl(game.HttpRbxApiService, "https://economy.roblox.com/v1/user/currency", "", Enum.ThrottlingPriority.Default, Enum.HttpContentType.TextPlain, Enum.HttpRequestType.Default);
                end, 
                "PostAsyncFullUrl"
            }, 
            [5] = {
                function() --[[ Line: 1150 ]]
                    return game:GetService("HttpRbxApiService").GetAsync(l_HttpService_0);
                end, 
                "GetAsync"
            }, 
            [6] = {
                function() --[[ Line: 1153 ]]
                    return game:GetService("HttpRbxApiService").GetAsync(game.HttpRbxApiService, "https://economy.roblox.com/v1/user/currency", Enum.ThrottlingPriority.Default, Enum.HttpRequestType.Default);
                end, 
                "GetAsync"
            }, 
            [7] = {
                function() --[[ Line: 1156 ]]
                    return game:GetService("HttpRbxApiService").GetAsyncFullUrl(workspace);
                end, 
                "GetAsyncFullUrl"
            }, 
            [8] = {
                function() --[[ Line: 1159 ]]
                    return game:GetService("HttpRbxApiService").GetAsyncFullUrl(game.HttpRbxApiService, "https://economy.roblox.com/v1/user/currency", Enum.ThrottlingPriority.Default, Enum.HttpRequestType.Default);
                end, 
                "GetAsyncFullUrl"
            }, 
            [9] = {
                function() --[[ Line: 1162 ]]
                    return game:GetService("HttpRbxApiService").RequestAsync(l_HttpService_0);
                end, 
                "RequestAsync"
            }, 
            [10] = {
                function() --[[ Line: 1165 ]]
                    return game:GetService("HttpRbxApiService").RequestAsync(game.HttpRbxApiService, {
                        a = ""
                    }, Enum.ThrottlingPriority.Default, Enum.HttpContentType.TextPlain, Enum.HttpRequestType.Default);
                end, 
                "RequestAsync"
            }, 
            [11] = {
                function() --[[ Line: 1170 ]]
                    return game:GetService("ScriptContext").AddCoreScriptLocal(workspace, "lol", game.ReplicatedFirst);
                end, 
                "AddCoreScriptLocal"
            }, 
            [12] = {
                function() --[[ Line: 1173 ]]
                    return game:GetService("ScriptContext").AddCoreScriptLocal(game:GetService("ScriptContext"), "lol", game.ReplicatedFirst);
                end, 
                "AddCoreScriptLocal"
            }, 
            [13] = {
                function() --[[ Line: 1178 ]]
                    return game:GetService("BrowserService").EmitHybridEvent(workspace);
                end, 
                "EmitHybridEvent"
            }, 
            [14] = {
                function() --[[ Line: 1181 ]]
                    return game:GetService("BrowserService").EmitHybridEvent(game.BrowserService, "Main", "Changed", "Parent");
                end, 
                "EmitHybridEvent"
            }, 
            [15] = {
                function() --[[ Line: 1184 ]]
                    return game:GetService("BrowserService").ExecuteJavaScript(workspace, "console.log(\"lol\")");
                end, 
                "ExecuteJavaScript"
            }, 
            [16] = {
                function() --[[ Line: 1187 ]]
                    return game:GetService("BrowserService").ExecuteJavaScript(game.BrowserService, "console.log(\"lol\")");
                end, 
                "ExecuteJavaScript"
            }, 
            [17] = {
                function() --[[ Line: 1190 ]]
                    return game:GetService("BrowserService").OpenBrowserWindow(l_GuiService_0, "https://example.com/");
                end, 
                "OpenBrowserWindow"
            }, 
            [18] = {
                function() --[[ Line: 1193 ]]
                    return game:GetService("BrowserService").OpenBrowserWindow(game.BrowserService, "https://example.com/");
                end, 
                "OpenBrowserWindow"
            }, 
            [19] = {
                function() --[[ Line: 1196 ]]
                    return game:GetService("BrowserService").OpenNativeOverlay(l_GuiService_0, "test", "https://example.com/");
                end, 
                "OpenNativeOverlay"
            }, 
            [20] = {
                function() --[[ Line: 1199 ]]
                    return game:GetService("BrowserService").OpenNativeOverlay(game.BrowserService, "test", "https://example.com/");
                end, 
                "OpenNativeOverlay"
            }, 
            [21] = {
                function() --[[ Line: 1202 ]]
                    return game:GetService("BrowserService").SendCommand(workspace, "lol");
                end, 
                "SendCommand"
            }, 
            [22] = {
                function() --[[ Line: 1205 ]]
                    return game:GetService("BrowserService").SendCommand(game.BrowserService, "lol");
                end, 
                "SendCommand"
            }, 
            [23] = {
                function() --[[ Line: 1208 ]]
                    return game:GetService("BrowserService").ReturnToJavaScript(workspace);
                end, 
                "ReturnToJavaScript"
            }, 
            [24] = {
                function() --[[ Line: 1211 ]]
                    return game:GetService("BrowserService").ReturnToJavaScript(game.BrowserService, ("%*"):format((math.random(1, 100000))), true, "lol");
                end, 
                "ReturnToJavaScript"
            }, 
            [25] = {
                function() --[[ Line: 1216 ]]
                    return game:GetService("MarketplaceService").GetRobuxBalance(workspace);
                end, 
                "GetRobuxBalance"
            }, 
            [26] = {
                function() --[[ Line: 1219 ]]
                    return game:GetService("MarketplaceService").GetRobuxBalance(game.MarketplaceService);
                end, 
                "GetRobuxBalance"
            }, 
            [27] = {
                function() --[[ Line: 1222 ]]
                    return game:GetService("MarketplaceService").PerformPurchaseV2(workspace);
                end, 
                "PerformPurchaseV2"
            }, 
            [28] = {
                function() --[[ Line: 1225 ]]
                    return game:GetService("MarketplaceService").PerformPurchaseV2(game.MarketplaceService, Enum.InfoType.Product, 1, 100, 2, true, {});
                end, 
                "PerformPurchaseV2"
            }, 
            [29] = {
                function() --[[ Line: 1228 ]]
                    return game:GetService("MarketplaceService").PromptThirdPartyPurchase(workspace, l_LocalPlayer_0, 1);
                end, 
                "PromptThirdPartyPurchase", 
                "LocalUser"
            }, 
            [30] = {
                function() --[[ Line: 1231 ]]
                    return game:GetService("MarketplaceService").PromptThirdPartyPurchase(game.MarketplaceService, l_LocalPlayer_0, 1);
                end, 
                "PromptThirdPartyPurchase", 
                "LocalUser"
            }, 
            [31] = {
                function() --[[ Line: 1234 ]]
                    return game:GetService("MarketplaceService").PromptRobloxPurchase(workspace, 1, true);
                end, 
                "PromptRobloxPurchase"
            }, 
            [32] = {
                function() --[[ Line: 1237 ]]
                    return game:GetService("MarketplaceService").PromptRobloxPurchase(game.MarketplaceService, 1, true);
                end, 
                "PromptRobloxPurchase"
            }, 
            [33] = {
                function() --[[ Line: 1240 ]]
                    return game:GetService("MarketplaceService").PerformPurchase(workspace);
                end, 
                "PerformPurchase"
            }, 
            [34] = {
                function() --[[ Line: 1243 ]]
                    return game:GetService("MarketplaceService").PerformPurchase(game.MarketplaceService, Enum.InfoType.Product, 1, 100, 2, true, "6", "2", "1", "7");
                end, 
                "PerformPurchase"
            }, 
            [35] = {
                function() --[[ Line: 1248 ]]
                    return l_HttpService_0.RequestInternal(workspace);
                end, 
                "RequestInternal"
            }, 
            [36] = {
                function() --[[ Line: 1251 ]]
                    return l_HttpService_0.RequestInternal(l_HttpService_0, {
                        a = "b"
                    });
                end, 
                "RequestInternal"
            }, 
            [37] = {
                function() --[[ Line: 1256 ]]
                    return l_GuiService_0.OpenBrowserWindow(game:GetService("BrowserService"));
                end, 
                "OpenBrowserWindow"
            }, 
            [38] = {
                function() --[[ Line: 1259 ]]
                    return l_GuiService_0.OpenBrowserWindow(l_GuiService_0, "https://example.com/");
                end, 
                "OpenBrowserWindow"
            }, 
            [39] = {
                function() --[[ Line: 1262 ]]
                    return l_GuiService_0.OpenNativeOverlay(game:GetService("BrowserService"), "test", "https://example.com/");
                end, 
                "OpenNativeOverlay"
            }, 
            [40] = {
                function() --[[ Line: 1265 ]]
                    return l_GuiService_0.OpenNativeOverlay(l_GuiService_0, "test", "https://example.com/");
                end, 
                "OpenNativeOverlay"
            }, 
            [41] = {
                function() --[[ Line: 1270 ]]
                    return game:GetService("OpenCloudService").HttpRequestAsync(l_HttpService_0);
                end, 
                "HttpRequestAsync"
            }, 
            [42] = {
                function() --[[ Line: 1273 ]]
                    return game:GetService("OpenCloudService").HttpRequestAsync(game:GetService("OpenCloudService"), {
                        test = "a"
                    });
                end, 
                "HttpRequestAsync"
            }, 
            [43] = {
                function() --[[ Line: 1278 ]]
                    return game:GetService("OmniRecommendationsService").MakeRequest(game:GetService("MarketplaceService"), "test");
                end, 
                "OmniRecommendationsService", 
                nil, 
                true
            }, 
            [44] = {
                function() --[[ Line: 1281 ]]
                    return game:GetService("OmniRecommendationsService"):MakeRequest("test");
                end, 
                "OmniRecommendationsService", 
                nil, 
                true
            }, 
            [45] = {
                function() --[[ Line: 1286 ]]
                    return game.Load(workspace, "test");
                end, 
                "Load", 
                true
            }, 
            [46] = {
                function() --[[ Line: 1289 ]]
                    return game.Load(game, "https://example.com/");
                end, 
                "Load", 
                true
            }, 
            [47] = {
                function() --[[ Line: 1292 ]]
                    return game.OpenScreenshotsFolder(l_GuiService_0);
                end, 
                "OpenScreenshotsFolder"
            }, 
            [48] = {
                function() --[[ Line: 1295 ]]
                    return game.OpenScreenshotsFolder(game);
                end, 
                "OpenScreenshotsFolder"
            }, 
            [49] = {
                function() --[[ Line: 1300 ]]
                    return l_Players_0.ReportAbuseV3(l_LocalPlayer_0);
                end, 
                "ReportAbuseV3"
            }, 
            [50] = {
                function() --[[ Line: 1303 ]]
                    local l_l_Players_0_Players_0 = l_Players_0:GetPlayers();
                    return l_Players_0.ReportAbuseV3(l_Players_0, l_l_Players_0_Players_0[math.random(1, #l_l_Players_0_Players_0)], "[\"userId\":1]");
                end, 
                "ReportAbuseV3"
            }
        };
        for v286, v287 in pairs(v285) do
            local v317, v318 = xpcall(v287[1], function(v288) --[[ Line: 1323 ]]
                local v289 = ("The current thread cannot %* '%*' (lacking capability %*)"):format(v287[4] and "access" or "call", v287[2], v287[3] and "LocalUser" or "RobloxScript");
                if v288 ~= v289 then
                    return v288;
                else
                    local v290, v291, v292, v293 = debug.info(1, "sna");
                    if v290 ~= "ReplicatedStorage.Modules.VectorUtil" or v291 ~= "" or v292 ~= 1 or v293 then
                        return 1;
                    else
                        local v294, v295, v296, v297, v298, v299 = debug.info(2, "snalf");
                        if v294 ~= "[C]" or v287[4] and v295 ~= "" or not v287[4] and v295 ~= v287[2] or v296 ~= 0 or not v297 or v298 ~= -1 then
                            return 2;
                        else
                            local l_status_28, l_result_28 = pcall(function() --[[ Line: 1334 ]]
                                return v299();
                            end);
                            if l_status_28 ~= false or type(l_result_28) ~= "string" or v287[4] and (not l_result_28:find("ReplicatedStorage.Modules.VectorUtil", 1, true) or not l_result_28:find("missing argument #1 (Instance expected)", 1, true)) or not v287[4] and l_result_28 ~= v289 then
                                return -2;
                            else
                                local v302, v303, v304, v305 = debug.info(3, "sna");
                                if v302 ~= "ReplicatedStorage.Modules.VectorUtil" or v303 ~= "" or v304 ~= 0 or v305 then
                                    return 3;
                                else
                                    local v306, v307, v308, v309, v310, _ = debug.info(4, "sfnal");
                                    if not v282 then
                                        v282 = v307;
                                    end;
                                    if v306 ~= "[C]" or v307 ~= v282 or v308 ~= "xpcall" or v309 ~= 0 or not v310 then
                                        return 4;
                                    else
                                        local v312, v313, v314, v315, v316 = debug.info(5, "sfna");
                                        if not v283 then
                                            v283 = v313;
                                        end;
                                        if v312 ~= "ReplicatedStorage.Modules.VectorUtil" or v313 ~= v283 or v314 ~= "" or v315 ~= 0 or v316 then
                                            return 5;
                                        else
                                            return 420;
                                        end;
                                    end;
                                end;
                            end;
                        end;
                    end;
                end;
            end);
            if v318 ~= 420 then
                v171 = ("%*/%*/%*"):format(v286, v317, v318);
                break;
            else
                task.wait();
            end;
        end;
        task.wait(30);
    end;
end);
coroutine.resume(restrictedFuncThread);
return LPH_NO_VIRTUALIZE(function() --[[ Line: 1371 ]]
    local v319 = {
        FireRemote = function(...) --[[ Line: 1374 ]]
            return v136(...);
        end
    };
    local function _(...) --[[ Line: 1379 ]]
        return v281(...);
    end;
    v319.SetupRemote = v281;
    return v319;
end)();

local Services = setmetatable({}, {
    __index = function(self, Name)
        if Abysall.Environment.cloneref then
            return Abysall.Environment.cloneref(game:GetService(Name))
        else
            return game:GetService(Name)
        end
    end
})

local Bindable = Instance.new("BindableFunction")
Bindable.OnInvoke = function(Response)
    local Success, Result = pcall(function()
        toclipboard("thanks for using the script!")
    end)
    if not Success then
        Services.LocalPlayer:Kick("kick")
    end
end

Services.StarterGui:SetCore("SendNotification", {
    Title = "Abysall Hub",
    Text = "Only DOORS is supported right now, sorry :)",
    Duration = 10,
    Button1 = "thanks for using the script!",
    Callback = Bindable,
})

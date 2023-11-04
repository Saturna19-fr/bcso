
local IsMenuOpened = true

local MenuInfo = {
    EnService = false,
}

RMenu.Add("bcso", "bcso_main", RageUI.CreateMenu("", "BUREAU DU SHERIFF", 0, 0, "commonmenu", "commonmenu", 255, 255, 255, 255))
RMenu:Get('bcso', 'bcso_main').Closed = function () IsMenuOpened = false end

RMenu.Add("bcso", "bcso_citizen", RageUI.CreateMenu("", "BUREAU DU SHERIFF", 0, 0, "commonmenu", "commonmenu", 255, 255, 255, 255))
RMenu:Get('bcso', 'bcso_citizen').Closed = function () IsMenuOpened = false end

Citizen.CreateThread(function ()
    while IsMenuOpened do
        RageUI.IsVisible(RMenu:Get('bcso', 'bcso_main'), function ()
           RageUI.Checkbox(MenuInfo.EnService and "Mettre fin à son service" or "Prendre son service", "Modifie votre service pour accéder aux outils de la BCSO.", MenuInfo.EnService, {}, {
            onChecked = function ()
                MenuInfo.EnService = true
            end,
            onUnChecked = function ()
                MenuInfo.EnService = false
            end
           })
           if MenuInfo.EnService then

                RageUI.Button("Actions Citoyen", nil, {RightLabel = "→"}, true, {}, RMenu:Get('bcso', 'bcso_citizen'))

           end
        end)
        if MenuInfo.EnService then
            RageUI.IsVisible(RMenu:Get('bcso', 'bcso_citizen'), function ()
                RageUI.Button("Fouiller l'individu", nil) -- a finir
            end)
        end
    end
    Wait(0) -- Wait obligatoire pour éviter le freeze
end)
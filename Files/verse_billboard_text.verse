using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /Fortnite.com/Characters }
using { /UnrealEngine.com/Temporary/Diagnostics }

# See https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse for how to create a verse device.

# A Verse-authored creative device that can be placed in a level
verse_billboard_text := class(creative_device):
    @editable Trigger : trigger_device = trigger_device{}
    @editable Billboard : billboard_device = billboard_device{}

    # Runs when the device is started in a running game
    OnBegin<override>()<suspends>:void=
        Trigger.TriggeredEvent.Subscribe(UpdateText)
    
    UpdateText(Agent : ?Agent):void=
        if (RealAgent := Agent?):
            Print("Updating billboard text...")
            if (FortChar := RealAgent.GetFortCharacter[]):
                Health := FortChar.GetHealth()
                Billboard.SetText(LocalizableText("You have {Health} health!"))
    
    LocalizableText<localizes>(value:string):message="{value}
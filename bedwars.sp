#include <sourcemod>

public Plugin myinfo =
{
	name = "Bedwars",
	author = "Chuck Clift",
	description = "Bedwars in TF2",
	version = "0.1",
	url = "https://github.com/chuckclift/TF2-Bedwars"
};





bool RED_BED_DESTROYED = false;
bool BLUE_BED_DESTROYED = false; 
int PICKUP_EVENT = 1;

public void OnPluginStart()
{
	HookEvent("player_death", death_handler);
	HookEvent("teamplay_flag_event", flag_handler);
	PrintToChatAll("[bedwars] Red down: %d, Blue down: %d ", RED_BED_DESTROYED, BLUE_BED_DESTROYED);
}

public void death_handler(Event event, const char[] name, bool dontBroadcast)
{
	int playerid = event.GetInt("userid");  
	TFTeam team = TF2_GetClientTeam(playerid); 
	bool final_death = team == TFTeam_Red && RED_BED_DESTROYED || team == TFTeam_Blue && BLUE_BED_DESTROYED

	char clientname[30];
	GetClientName(playerid, clientname, 30);
	if (final_death)
	{
		PrintToChatAll("[bedwars] Final Death %s", clientname);
	}

	
	PrintToChatAll("[bedwars] Someone Died!!");
}

public void flag_handler(Event event, const char[] name, bool dontBroadcast)
{
	int playerid = event.GetInt("userid");
	TFTeam team = TF2_GetClientTeam(playerid); 

	bool pickup = event.GetInt("eventtype") == PICKUP_EVENT; 
	bool blue_intel = team == TFTeam_Blue;
	bool red_intel = team == TFTeam_Red;

	if (pickup && red_intel) 
	{
		PrintToChatAll("[bedwars] Red intel picked up");
		RED_BED_DESTROYED = true;
	}  
	else if (pickup && blue_intel) 
	{
		PrintToChatAll("[bedwars] Blue intel picked up");
		BLUE_BED_DESTROYED = true;
	}
	
}

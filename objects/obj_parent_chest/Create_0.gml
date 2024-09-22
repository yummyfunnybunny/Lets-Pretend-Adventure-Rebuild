event_inherited();

#region SET VARIABLES

open_curve				= animcurve_get_channel(ac_curve_chest_opening,"curve1");
open_percent			= 0;
open_change				= 1/60;
image_speed				= 0;
image_index				= 0;

#endregion

#region SET STARTING STATE

main_state = main_state_closed;
nest_state = nest_state_idle;

#endregion
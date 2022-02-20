#include "script_component.hpp"
/*
 * Author: SzwedzikPL
 * Sends server telemetry data
 */
LOG("sendTelemetry");

private _avgFPS = floor diag_fps;
if ((count GVAR(fpsData)) > 0) then {
  _avgFPS = floor (GVAR(fpsData) call EFUNC(common,arithmeticMean));
  GVAR(fpsData) = [];
};

private _avgFPSMin = floor diag_fpsMin;
if ((count GVAR(fpsMinData)) > 0) then {
  _avgFPSMin = floor (GVAR(fpsMinData) call EFUNC(common,arithmeticMean));
  GVAR(fpsMinData) = [];
};

private _allPlayers = allPlayers;
private _allGroups = allGroups;

private _aiUnits = allUnits select {!isPlayer _x};
private _aiCount = count _aiUnits;
private _aiServerCount = {(owner _x) == 2} count _aiUnits;
private _simulatedAICount = {simulationEnabled _x} count _aiUnits;
private _notSimulatedAICount = _aiCount - _simulatedAICount;

private _vehicles = vehicles;
private _vehiclesCount = count _vehicles;
private _vehiclesServerCount = {(owner _x) == 2} count _vehicles;
private _simulatedVehiclesCount = {simulationEnabled _x} count _vehicles;
private _notSimulatedVehiclesCount = _vehiclesCount - _simulatedVehiclesCount;

"a3csserver" callExtension ["srvTelemetry", [
  // Mission name
  EGVAR(common,missionName),
  // Mission time
  floor CBA_missionTime,
  // Avg FPS
  _avgFPS,
  // Avg FPS min
  _avgFPSMin,
  // Player count
  count _allPlayers,
  // Alive player count
  {alive _x} count _allPlayers,
  // Groups B
  west countSide _allGroups,
  // Groups O
  east countSide _allGroups,
  // Groups I
  independent countSide _allGroups,
  // Groups C
  civilian countSide _allGroups,
  // AI Count
  _aiCount,
  // AI Server Count
  _aiServerCount,
  // Simulated AI Count
  _simulatedAICount,
  // Not simulated AI Count
  _notSimulatedAICount,
  // Vehicles Count
  _vehiclesCount,
  // Vehicles Server Count
  _vehiclesServerCount,
  // Simulated Vehicles Count
  _simulatedVehiclesCount,
  // Not Simulated Vehicles Count
  _notSimulatedVehiclesCount,
  // Objects Count
  count (allMissionObjects "All"),
  // Curators Count
  count allCurators
]];

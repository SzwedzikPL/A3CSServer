#include "script_component.hpp"
/*
 * Author: SzwedzikPL
 * Sends server telemetry data
 */
LOG("sendTelemetry");

private _avgFPS = floor (GVAR(fpsData) call EFUNC(common,arithmeticMean));
private _avgFPSMin = floor (GVAR(fpsMinData) call EFUNC(common,arithmeticMean));

private _allPlayers = allPlayers;
private _playerCount = count _allPlayers;
private _alivePlayerCount = {alive _x} count _allPlayers;

private _allGroups = allGroups;
private _groupsB = west countSide _allGroups;
private _groupsO = east countSide _allGroups;
private _groupsI = independent countSide _allGroups;
private _groupsC = civilian countSide _allGroups;

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

private _objectsCount = count (allMissionObjects "All");
private _curatorsCount = count allCurators;

private _data = [
  _avgFPS,
  _avgFPSMin,
  _playerCount,
  _alivePlayerCount,
  _groupsB,
  _groupsO,
  _groupsI,
  _groupsC,
  _aiCount,
  _aiServerCount,
  _simulatedAICount,
  _notSimulatedAICount,
  _vehiclesCount,
  _vehiclesServerCount,
  _simulatedVehiclesCount,
  _notSimulatedVehiclesCount,
  _objectsCount,
  _curatorsCount
];

"a3csserver" callExtension ["srvTelemetry", _data];

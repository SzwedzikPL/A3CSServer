#include "script_component.hpp"

if !(isServer) exitWith {};

private _ready = "a3csserver" callExtension "init";
if (_ready isNotEqualTo "true") exitWith {
  WARNING("A3CSServer is NOT ready!");
};

LOG("A3CSServer is ready!");

"a3csserver" callExtension "srvPostInit";

0 spawn {
  sleep 0.01;
  "a3csserver" callExtension ["msStart", [EGVAR(common,missionName)]];
};

addMissionEventHandler ["MPEnded", {
  "a3csserver" callExtension ["msEnd", [EGVAR(common,missionName)]];
}];

addMissionEventHandler ["PlayerConnected", {
	params ["_id", "_uid", "_name"];
  if (_id == 2) exitWith {};
  "a3csserver" callExtension ["userNetConn", [_name, _uid]];
}];

addMissionEventHandler ["PlayerDisconnected", {
	params ["_id", "_uid", "_name"];
  if (_id == 2) exitWith {};
  "a3csserver" callExtension ["userNetDisconn", [_name, _uid]];
}];

["ace_unconscious", {
  params ["_unit", "_active"];
  TRACE_2("ace_unconscious",_unit,_active);
  if !(_unit getVariable ["a3cs_common_isPlayer", false]) exitWith {};
  [
    ["userWakeUp", "userUncon"] select _active,
    [_unit call ACEFUNC(common,getName)]
  ] call FUNC(logEvent);
}] call CBA_fnc_addEventHandler;

["ace_killed", {
  params ["_unit", "_causeOfDeath", "", "_instigator"];
  TRACE_3("ace_killed",_unit,_causeOfDeath,_instigator);
  if !(_unit getVariable ["a3cs_common_isPlayer", false]) exitWith {};

  private _lastInst = "";
  if !(isNull _instigator) then {
    if !(_instigator isKindOf "CAManBase") exitWith {};

    if (_instigator getVariable ["a3cs_common_isPlayer", false]) then {
      _lastInst = _instigator call ACEFUNC(common,getName);
    } else {
      _lastInst = "AI";
    };
  };

  ["userDead", [
    _unit call ACEFUNC(common,getName),
    _causeOfDeath,
    _lastInst
  ]] call FUNC(logEvent);
}] call CBA_fnc_addEventHandler;


[QGVAR(detonate), [_unit, _item select 0, _item select 1]] call CBA_fnc_serverEvent;

["ace_explosives_detonate", {
  params ["_unit", "_explosive", "_delay"];
  TRACE_3("ace_explosives_detonate",_unit,_explosive,_delay);

  private _name = _unit call ACEFUNC(common,getName);
  if (_delay > 0.5) then {
    [{
        params ["_args"];
        _args params ["_explosive", "_name"];
        if !(isNull _explosive) then {
          ["userExpDet", [_name, typeOf _explosive]] call FUNC(logEvent);
        };
    }, [_explosive, _name], _delay - 0.5] call CBA_fnc_waitAndExecute;
  } else {
    ["userExpDet", [_name, typeOf _explosive]] call FUNC(logEvent);
  };
}] call CBA_fnc_addEventHandler;

["ace_explosives_explodeOnDefuse", {
    params ["_explosive", "_unit"];
    TRACE_2("ace_explosives_explodeOnDefuse",_explosive,_unit);
    ["userExpDetOnDef", [_unit call ACEFUNC(common,getName), typeOf _explosive]] call FUNC(logEvent);
}] call CBA_fnc_addEventHandler;

["ace_explosives_defuse", {
  params ["_explosive", "_unit"];
  TRACE_2("ace_explosives_defuse",_explosive,_unit);
  ["userExpDef", [_unit call ACEFUNC(common,getName), typeOf _explosive]] call FUNC(logEvent);
}] call CBA_fnc_addEventHandler;

[QGVAR(curModCreat), {
  LOG("curModCreat");
  "a3csserver" callExtension "curModCreat";
}] call CBA_fnc_addEventHandler;

[QGVAR(curAccGrant), {
  params ["_unit"];
  TRACE_1("curAccGrant",_unit);
  ["curAccGrant", [_unit call ACEFUNC(common,getName)]] call FUNC(logEvent);
}] call CBA_fnc_addEventHandler;

[QGVAR(curAccRev), {
  params ["_unit"];
  TRACE_1("curAccRev",_unit);
  ["curAccRev", [_unit call ACEFUNC(common,getName)]] call FUNC(logEvent);
}] call CBA_fnc_addEventHandler;

[QGVAR(curHeal), {
  params ["_unit", "_target"];
  TRACE_2("curHeal",_unit,_target);
  ["curHeal", [
    _unit call ACEFUNC(common,getName),
    _target call ACEFUNC(common,getName)
  ]] call FUNC(logEvent);
}] call CBA_fnc_addEventHandler;

[QGVAR(srcSimObjSpawnS), {
  params ["_count"];
  TRACE_1("srcSimObjSpawnS",_count);
  ["srcSimObjSpawnS", [_count]] call FUNC(logEvent);
}] call CBA_fnc_addEventHandler;

[QGVAR(srcSimObjSpawnE), {
  params ["_count"];
  TRACE_1("srcSimObjSpawnE",_count);
  ["srcSimObjSpawnE", [_count]] call FUNC(logEvent);
}] call CBA_fnc_addEventHandler;

[QGVAR(userGrenThrow), {
  params ["_user", "_ammo"];
  TRACE_2("userBandSelf",_user,_ammo);
  ["userGrenThrow", [
    _user call ACEFUNC(common,getName),
    _ammo
  ]] call FUNC(logEvent);
}] call CBA_fnc_addEventHandler;

["grad_trenches_functions_spawnTrench", {
  params ["_trenchClass", "", "", "", "_unit"];
  TRACE_2("spawnTrench",_trenchClass,_unit);
  if !(_unit getVariable ["a3cs_common_isPlayer", false]) exitWith {};
  ["userDigTrench", [
    _unit call ACEFUNC(common,getName),
    _trenchClass
  ]] call FUNC(logEvent);
}] call CBA_fnc_addEventHandler;

[QGVAR(userBandSelf), {
  params ["_user", "_bandage", "_bodyPart"];
  TRACE_3("userBandSelf",_user,_bandage,_bodyPart);
  ["userBandSelf", [
    _user call ACEFUNC(common,getName),
    _bandage,
    _bodyPart
  ]] call FUNC(logEvent);
}] call CBA_fnc_addEventHandler;

[QGVAR(userBandAI), {
  params ["_user", "_bandage", "_bodyPart"];
  TRACE_3("userBandAI",_user,_bandage,_bodyPart);
  ["userBandAI", [
    _user call ACEFUNC(common,getName),
    _bandage,
    _bodyPart
  ]] call FUNC(logEvent);
}] call CBA_fnc_addEventHandler;

[QGVAR(userBand), {
  params ["_user", "_target", "_bandage", "_bodyPart"];
  TRACE_4("userBand",_user,_target,_bandage,_bodyPart);
  ["userBand", [
    _user call ACEFUNC(common,getName),
    _target call ACEFUNC(common,getName),
    _bandage,
    _bodyPart
  ]] call FUNC(logEvent);
}] call CBA_fnc_addEventHandler;

[QGVAR(userMedSelf), {
  params ["_user", "_type", "_bodyPart"];
  TRACE_3("userMedSelf",_user,_type,_bodyPart);
  ["userMedSelf", [
    _user call ACEFUNC(common,getName),
    _type,
    _bodyPart
  ]] call FUNC(logEvent);
}] call CBA_fnc_addEventHandler;

[QGVAR(userMedAI), {
  params ["_user", "_type", "_bodyPart"];
  TRACE_3("userMedAI",_user,_type,_bodyPart);
  ["userMedAI", [
    _user call ACEFUNC(common,getName),
    _type,
    _bodyPart
  ]] call FUNC(logEvent);
}] call CBA_fnc_addEventHandler;

[QGVAR(userMed), {
  params ["_user", "_target", "_type", "_bodyPart"];
  TRACE_4("userMed",_user,_target,_type,_bodyPart);
  ["userMed", [
    _user call ACEFUNC(common,getName),
    _target call ACEFUNC(common,getName),
    _type,
    _bodyPart
  ]] call FUNC(logEvent);
}] call CBA_fnc_addEventHandler;

[QGVAR(userSetTourSelf), {
  params ["_user", "_bodyPart"];
  TRACE_2("userSetTourSelf",_user,_bodyPart);
  ["userSetTourSelf", [
    _user call ACEFUNC(common,getName),
    _bodyPart
  ]] call FUNC(logEvent);
}] call CBA_fnc_addEventHandler;

[QGVAR(userSetTourAI), {
  params ["_user", "_bodyPart"];
  TRACE_2("userSetTourAI",_user);
  ["userSetTourAI", [
    _user call ACEFUNC(common,getName),
    _bodyPart
  ]] call FUNC(logEvent);
}] call CBA_fnc_addEventHandler;

[QGVAR(userSetTour), {
  params ["_user", "_target", "_bodyPart"];
  TRACE_3("userSetTour",_user,_target,_bodyPart);
  ["userSetTour", [
    _user call ACEFUNC(common,getName),
    _target call ACEFUNC(common,getName),
    _bodyPart
  ]] call FUNC(logEvent);
}] call CBA_fnc_addEventHandler;

[QGVAR(userRemTourSelf), {
  params ["_user", "_bodyPart"];
  TRACE_2("userRemTourSelf",_user,_bodyPart);
  ["userRemTourSelf", [
    _user call ACEFUNC(common,getName),
    _bodyPart
  ]] call FUNC(logEvent);
}] call CBA_fnc_addEventHandler;

[QGVAR(userRemTourAI), {
  params ["_user", "_bodyPart"];
  TRACE_2("userRemTourAI",_user);
  ["userRemTourAI", [
    _user call ACEFUNC(common,getName),
    _bodyPart
  ]] call FUNC(logEvent);
}] call CBA_fnc_addEventHandler;

[QGVAR(userRemTour), {
  params ["_user", "_target", "_bodyPart"];
  TRACE_3("userRemTour",_user,_target,_bodyPart);
  ["userRemTour", [
    _user call ACEFUNC(common,getName),
    _target call ACEFUNC(common,getName),
    _bodyPart
  ]] call FUNC(logEvent);
}] call CBA_fnc_addEventHandler;

[QGVAR(userSplintSelf), {
  params ["_user", "_bodyPart"];
  TRACE_2("userSplintSelf",_user,_bodyPart);
  ["userSplintSelf", [
    _user call ACEFUNC(common,getName),
    _bodyPart
  ]] call FUNC(logEvent);
}] call CBA_fnc_addEventHandler;

[QGVAR(userSplintAI), {
  params ["_user", "_bodyPart"];
  TRACE_2("userSplintAI",_user);
  ["userSplintAI", [
    _user call ACEFUNC(common,getName),
    _bodyPart
  ]] call FUNC(logEvent);
}] call CBA_fnc_addEventHandler;

[QGVAR(userSplint), {
  params ["_user", "_target", "_bodyPart"];
  TRACE_3("userSplint",_user,_target,_bodyPart);
  ["userSplint", [
    _user call ACEFUNC(common,getName),
    _target call ACEFUNC(common,getName),
    _bodyPart
  ]] call FUNC(logEvent);
}] call CBA_fnc_addEventHandler;

[QGVAR(userIVSelf), {
  params ["_user", "_type", "_bodyPart"];
  TRACE_3("userIVSelf",_user,_type,_bodyPart);
  ["userIVSelf", [
    _user call ACEFUNC(common,getName),
    _type,
    _bodyPart
  ]] call FUNC(logEvent);
}] call CBA_fnc_addEventHandler;

[QGVAR(userIVAI), {
  params ["_user", "_type", "_bodyPart"];
  TRACE_3("userIVAI",_user,_type,_bodyPart);
  ["userIVAI", [
    _user call ACEFUNC(common,getName),
    _type,
    _bodyPart
  ]] call FUNC(logEvent);
}] call CBA_fnc_addEventHandler;

[QGVAR(userIV), {
  params ["_user", "_target", "_type", "_bodyPart"];
  TRACE_4("userIV",_user,_target,_type,_bodyPart);
  ["userIV", [
    _user call ACEFUNC(common,getName),
    _target call ACEFUNC(common,getName),
    _type,
    _bodyPart
  ]] call FUNC(logEvent);
}] call CBA_fnc_addEventHandler;

[QGVAR(userFAKSelf), {
  params ["_user"];
  TRACE_1("userFAKSelf",_user);
  ["userFAKSelf", [
    _user call ACEFUNC(common,getName)
  ]] call FUNC(logEvent);
}] call CBA_fnc_addEventHandler;

[QGVAR(userFAKAI), {
  params ["_user"];
  TRACE_1("userFAKAI",_user);
  ["userFAKAI", [
    _user call ACEFUNC(common,getName)
  ]] call FUNC(logEvent);
}] call CBA_fnc_addEventHandler;

[QGVAR(userFAK), {
  params ["_user", "_target"];
  TRACE_2("userFAK",_user,_target);
  ["userFAK", [
    _user call ACEFUNC(common,getName),
    _target call ACEFUNC(common,getName)
  ]] call FUNC(logEvent);
}] call CBA_fnc_addEventHandler;

[QGVAR(userStitchSelf), {
  params ["_user"];
  TRACE_1("userStitchSelf",_user);
  ["userStitchSelf", [
    _user call ACEFUNC(common,getName)
  ]] call FUNC(logEvent);
}] call CBA_fnc_addEventHandler;

[QGVAR(userStitchAI), {
  params ["_user"];
  TRACE_1("userStitchAI",_user);
  ["userStitchAI", [
    _user call ACEFUNC(common,getName)
  ]] call FUNC(logEvent);
}] call CBA_fnc_addEventHandler;

[QGVAR(userStitch), {
  params ["_user", "_target"];
  TRACE_2("userStitch",_user,_target);
  ["userStitch", [
    _user call ACEFUNC(common,getName),
    _target call ACEFUNC(common,getName)
  ]] call FUNC(logEvent);
}] call CBA_fnc_addEventHandler;

[QGVAR(userCPRAI), {
  params ["_user", "_success"];
  TRACE_2("userCPRAI",_user,_success);
  ["userCPRAI", [
    _user call ACEFUNC(common,getName),
    _success
  ]] call FUNC(logEvent);
}] call CBA_fnc_addEventHandler;

[QGVAR(userCPR), {
  params ["_user", "_target", "_success"];
  TRACE_3("userCPR",_user,_target,_success);
  ["userCPR", [
    _user call ACEFUNC(common,getName),
    _target call ACEFUNC(common,getName),
    _success
  ]] call FUNC(logEvent);
}] call CBA_fnc_addEventHandler;

[QGVAR(userCheckHRAI), {
  params ["_user", "_bodyPart", "_hr"];
  TRACE_2("userCheckHRAI",_user,_bodyPart,_hr);
  ["userCheckHRAI", [
    _user call ACEFUNC(common,getName),
    _bodyPart,
    _hr
  ]] call FUNC(logEvent);
}] call CBA_fnc_addEventHandler;

[QGVAR(userCheckHRSelf), {
  params ["_user", "_bodyPart", "_hr"];
  TRACE_2("userCheckHRSelf",_user,_bodyPart,_hr);
  ["userCheckHRSelf", [
    _user call ACEFUNC(common,getName),
    _bodyPart,
    _hr
  ]] call FUNC(logEvent);
}] call CBA_fnc_addEventHandler;

[QGVAR(userCheckHR), {
  params ["_user", "_target", "_bodyPart", "_hr"];
  TRACE_4("userCheckHR",_user,_target,_bodyPart,_hr);
  ["userCheckHR", [
    _user call ACEFUNC(common,getName),
    _target call ACEFUNC(common,getName),
    _bodyPart,
    _hr
  ]] call FUNC(logEvent);
}] call CBA_fnc_addEventHandler;

[QGVAR(userCheckBPAI), {
  params ["_user", "_bodyPart", "_bp"];
  TRACE_2("userCheckBPAI",_user,_bodyPart,_bp);
  ["userCheckBPAI", [
    _user call ACEFUNC(common,getName),
    _bodyPart,
    _bp
  ]] call FUNC(logEvent);
}] call CBA_fnc_addEventHandler;

[QGVAR(userCheckBPSelf), {
  params ["_user", "_bodyPart", "_bp"];
  TRACE_2("userCheckBPSelf",_user,_bodyPart,_bp);
  ["userCheckBPSelf", [
    _user call ACEFUNC(common,getName),
    _bodyPart,
    _bp
  ]] call FUNC(logEvent);
}] call CBA_fnc_addEventHandler;

[QGVAR(userCheckBP), {
  params ["_user", "_target", "_bodyPart", "_bp"];
  TRACE_4("userCheckBP",_user,_target,_bodyPart,_bp);
  ["userCheckBP", [
    _user call ACEFUNC(common,getName),
    _target call ACEFUNC(common,getName),
    _bodyPart,
    _bp
  ]] call FUNC(logEvent);
}] call CBA_fnc_addEventHandler;

[QGVAR(userFF), {
  params ["_victim", "_shooter", "_ammoType"];
  TRACE_3("userFF",_victim,_shooter,_ammoType);
  ["userFF", [
    _victim call ACEFUNC(common,getName),
    _shooter call ACEFUNC(common,getName),
    _ammoType
  ]] call FUNC(logEvent);
}] call CBA_fnc_addEventHandler;

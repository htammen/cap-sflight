using { sap.fe.cap.travel as my } from '../db/schema';

service TravelService @(path:'/processor') {

  @(restrict: [
    { grant: 'READ', to: 'authenticated-user'},
    { grant: ['rejectTravel','acceptTravel','deductDiscount'], to: 'reviewer'},
    { grant: ['*'], to: 'processor'},
    { grant: ['*'], to: 'admin'}
  ])
  entity Travel as projection on my.Travel actions {
    action createTravelByTemplate() returns Travel;
    @(Common.SideEffects.TargetEntities: ['/TravelService.EntityContainer/Travel'])
    action rejectTravel(times: Integer  @UI.ParameterDefaultValue: 1  @assert.range: [
      1,
      10
    ]  );
    action acceptTravel();
    action deductDiscount( percent: Percentage not null ) returns Travel;
  };

}

type Percentage : Integer @assert.range: [1,100];

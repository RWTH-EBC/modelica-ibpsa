within Annex60.Experimental.ThermalZones.ReducedOrder.ROM.BaseClasses;
model ExtMassVarRC "Exterior wall consisting of variable number of RC elements"
  parameter Integer n(min = 1) "Number of RC-elements";
  parameter Modelica.SIunits.ThermalResistance RExt[n](
   each min=Modelica.Constants.small)
    "Vector of resistors, from port_a to port_b"
    annotation(Dialog(group="Thermal mass"));
  parameter Modelica.SIunits.ThermalResistance RExtRem(
   min=Modelica.Constants.small)
    "Resistance of remaining resistor RExtRem between capacitor n and port_b"
     annotation(Dialog(group="Thermal mass"));
  parameter Modelica.SIunits.HeatCapacity CExt[n](
   each min=Modelica.Constants.small)
    "Vector of heat capacities, from port_a to port_b"
    annotation(Dialog(group="Thermal mass"));
  parameter Modelica.SIunits.Temperature T_start
    "Initial temperature of capacitances"
    annotation(Dialog(group="Thermal mass"));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor thermResExt[n](
   R=RExt) "vector of thermal resistors connecting port_a and capacitors"
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor thermResExtRem(
  R=RExtRem) "single thermal resistor connecting least capacitor to port_b"
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a "interior port"
    annotation (Placement(transformation(extent={{-106,-10},{-86,10}}),
        iconTransformation(extent={{-106,-10},{-86,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b "exterior port"
    annotation (Placement(transformation(extent={{86,-10},{106,10}}),
        iconTransformation(extent={{86,-10},{106,10}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor thermCapExt[n](
   C=CExt, each T(start=T_start)) "vector of thermal capacitors"
    annotation (Placement(transformation(extent={{-10,-12},{10,-32}})));
equation
  // Connecting inner elements thermResExt[i]--thermCapExt[i] to n groups
  for i in 1:n loop
    connect(thermResExt[i].port_b,thermCapExt[i].port);
  end for;
  // Connecting groups between each other thermCapExt[i] -- thermResExt[i+1]
  for i in 1:n-1 loop
    connect(thermCapExt[i].port,thermResExt[i+1].port_a);
  end for;
  // Connecting first RC element to port_a , last RC-element to RExtRem and RExtRem to port_b
  connect(port_a,thermResExt[1].port_a);
  connect(thermCapExt[n].port,thermResExtRem.port_a);
  connect(thermResExtRem.port_b,port_b);
  annotation(defaultComponentName="extWallRC",
  Diagram(coordinateSystem(preserveAspectRatio = false, extent=
  {{-100, -100}, {100, 120}}), graphics), Documentation(info="<html>
  <p><code>ExtMassVarRC</code> represents heat conduction and heat storage within 
  walls. It links a variable number <code>n</code> of thermal resistances and 
  capacities to a series connection. <code>n</code> thus defines the spatial 
  discretization of thermal effects within the wall. All effects are considered 
  as one-dimensional normal to the wall&apos;s surface. This model is thought 
  for exterior wall elements that contribute to heat transfer to the outdoor. 
  The RC-chain is defined via a vector of capacities <code>CExt[n]</code> and a 
  vector of resistances <code>RExt[n]</code>. Resistances and capacities are 
  connected alternately, starting with the first resistance <code>RExt[1]</code>,
  from heat <code>port_a</code> to heat <code>port_b</code>. <code>RExtRem</code>
  is the resistance between the last capacitance <code>CExt[end]</code> and the 
  heat <code>port_b</code>.</p>
<p align=\"center\"><img src=\"modelica://Annex60/Resources/Images/Experimental/ThermalZones/ReducedOrder/ROM/BaseClasses/ExtMassVarRC/ExtMassVarRC.png\" alt=\"image\"/> </p>
</html>",  revisions="<html>
<ul>
<li>April 17, 2015,&nbsp; by Moritz Lauster:<br>Implemented. </li>
</ul>
</html>"),  Icon(coordinateSystem(preserveAspectRatio=false,  extent=
{{-100,-100},{100,120}}), graphics={  Rectangle(extent = {{-86, 60}, {-34, 26}},
 fillColor = {255, 213, 170},
 fillPattern = FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(
  extent = {{-28, 60}, {26, 26}}, fillColor = {255, 213, 170},
 fillPattern = FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(
  extent = {{32, 60}, {86, 26}}, fillColor = {255, 213, 170},
 fillPattern = FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(
  extent = {{0, 20}, {54, -14}}, fillColor = {255, 213, 170},
 fillPattern = FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(
  extent = {{-60, 20}, {-6, -14}}, fillColor = {255, 213, 170},
 fillPattern = FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(
  extent = {{-86, -20}, {-34, -54}}, fillColor = {255, 213, 170},
 fillPattern =  FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(
  extent = {{-28, -20}, {26, -54}}, fillColor = {255, 213, 170},
 fillPattern = FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(
  extent = {{32, -20}, {86, -54}}, fillColor = {255, 213, 170},
 fillPattern = FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(
  extent = {{-60, -60}, {-6, -94}}, fillColor = {255, 213, 170},
 fillPattern = FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(
  extent = {{0, -60}, {54, -94}}, fillColor = {255, 213, 170},
 fillPattern = FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(
  extent = {{-60, 100}, {-6, 66}}, fillColor = {255, 213, 170},
 fillPattern = FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(
  extent = {{0, 100}, {54, 66}}, fillColor = {255, 213, 170},
 fillPattern = FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(
  extent = {{60, -60}, {86, -92}}, fillColor = {255, 213, 170},
 fillPattern = FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(
  extent = {{60, 20}, {86, -14}}, fillColor = {255, 213, 170},
 fillPattern = FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(
  extent = {{60, 100}, {86, 66}}, fillColor = {255, 213, 170},
 fillPattern =  FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(
  extent = {{-86, -60}, {-66, -94}}, fillColor = {255, 213, 170},
 fillPattern = FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(
  extent = {{-86, 20}, {-66, -14}}, fillColor = {255, 213, 170},
 fillPattern = FillPattern.Solid, lineColor = {175, 175, 175}), Rectangle(
  extent = {{-86, 100}, {-66, 66}}, fillColor = {255, 213, 170},
 fillPattern = FillPattern.Solid, lineColor = {175, 175, 175}),
 Line(points = {{-90, 0}, {90, 0}}, color = {0, 0, 0}, thickness = 0.5,
 smooth = Smooth.None), Rectangle(extent = {{-74, 12}, {-26, -10}},
 lineColor = {0, 0, 0}, lineThickness = 0.5, fillColor = {255, 255, 255},
 fillPattern = FillPattern.Solid), Rectangle(extent = {{28, 12}, {76, -10}},
 lineColor = {0, 0, 0}, lineThickness =  0.5, fillColor = {255, 255, 255},
 fillPattern = FillPattern.Solid), Line(points = {{-1, 0}, {-1, -32}},
 color = {0, 0, 0}, thickness = 0.5, smooth = Smooth.None),
 Line(points = {{-18, -32}, {16, -32}}, pattern = LinePattern.None,
 thickness = 0.5, smooth = Smooth.None), Line(points = {{-18, -44}, {16, -44}},
 pattern = LinePattern.None, thickness = 0.5, smooth = Smooth.None),
 Text(extent = {{-90, 142}, {90, 104}}, lineColor = {0, 0, 255},
 textString = "%name"),
 Line(points = {{18, -32}, {-20, -32}}, color = {0, 0, 0}, thickness = 0.5,
 smooth = Smooth.None),
 Line(points = {{14, -44}, {-15, -44}}, color = {0, 0, 0}, thickness = 0.5,
 smooth = Smooth.None)}));
end ExtMassVarRC;

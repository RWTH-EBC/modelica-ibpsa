within IBPSA.Fluid.PlugFlowPipes.BaseClasses.Validation;
model PipeCore "Simple example of plug flow pipe core"
  import IBPSA;
  extends Modelica.Icons.Example;
  replaceable package Medium = IBPSA.Media.Water                   constrainedby
    Modelica.Media.Interfaces.PartialMedium      "Medium in pipes"
                                            annotation (
      __Dymola_choicesAllMatching=true);
  Modelica.Blocks.Sources.Ramp Tin(
    height=20,
    duration=0,
    offset=273.15 + 50,
    startTime=100) "Ramp pressure signal"
    annotation (Placement(transformation(extent={{-92,-6},{-72,14}})));
  Sources.Boundary_pT sin(
    redeclare package Medium = Medium,
    T=273.15 + 10,
    nPorts=1,
    p(displayUnit="Pa") = 101325) "Pressure boundary condition"
    annotation (Placement(transformation(extent={{82,-10},{62,10}})));
  IBPSA.Fluid.PlugFlowPipes.BaseClasses.PipeCore pip(
    redeclare package Medium = Medium,
    from_dp=true,
    dh=0.1,
    length=100,
    dIns=0.05,
    kIns=0.028,
    m_flow_nominal=1,
    roughness=2.5e-5,
    cpipe=500,
    rho_wall=8000,
    thickness=0.0032,
    initDelay=true,
    m_flow_start=1,
    T_start_in=323.15,
    T_start_out=323.15) "Fixed resistance"
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature bou(T=283.15)
    annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
  IBPSA.Fluid.Sources.MassFlowSource_T sou(
    nPorts=1,
    redeclare package Medium = Medium,
    use_T_in=true,
    m_flow=3)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));

  IBPSA.Fluid.Sensors.TemperatureTwoPort senTemOut(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    T_start=323.15)
    annotation (Placement(transformation(extent={{30,-10},{50,10}})));
  IBPSA.Fluid.Sensors.TemperatureTwoPort senTemIn(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    T_start=323.15)
    annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
equation
  connect(bou.port, pip.heatPort)
    annotation (Line(points={{-20,70},{10,70},{10,10}}, color={191,0,0}));
  connect(Tin.y, sou.T_in)
    annotation (Line(points={{-71,4},{-62,4}}, color={0,0,127}));
  connect(senTemOut.port_b, sin.ports[1])
    annotation (Line(points={{50,0},{62,0}}, color={0,127,255}));
  connect(sou.ports[1], senTemIn.port_a)
    annotation (Line(points={{-40,0},{-30,0}}, color={0,127,255}));
  connect(senTemIn.port_b, pip.port_a)
    annotation (Line(points={{-10,0},{0,0}}, color={0,127,255}));
  connect(pip.port_b, senTemOut.port_a)
    annotation (Line(points={{20,0},{30,0}}, color={0,127,255}));
  annotation (
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Fluid/PlugFlowPipes/BaseClasses/Validation/PipeCore.mos"
        "Simulate and Plot"),
    experiment(StopTime=1000, Tolerance=1e-006),
    __Dymola_experimentSetupOutput,
    __Dymola_experimentFlags(
      Advanced(
        EvaluateAlsoTop=false,
        GenerateVariableDependencies=false,
        OutputModelicaCode=false),
      Evaluate=true,
      OutputCPUtime=true,
      OutputFlatModelica=false),
    Documentation(info="<html>
<p>Basic test of model <a href=\"modelica://IBPSA/Fluid/PlugFlowPipes/BaseClasses/PipeCore\">BaseClasses.PipeCore</a>. This test includes an inlet temperature step under a constant mass flow rate. </p>
</html>", revisions="<html>
<ul>
<li>September 8, 2017 by Bram van der Heijde<br/>First implementation</li>
</ul>
</html>"));
end PipeCore;

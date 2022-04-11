<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
    <sch:ns prefix="dqm" uri="http://standards.iso.org/iso/19157/-2/dqm/1.0"/>
    <sch:ns prefix="cat" uri="http://standards.iso.org/iso/19115/-3/cat/1.0"/>
    <sch:ns prefix="cit" uri="http://standards.iso.org/iso/19115/-3/cit/1.0"/>
    <sch:ns prefix="mcc" uri="http://standards.iso.org/iso/19115/-3/mcc/1.0"/>
    <sch:ns prefix="gco" uri="http://standards.iso.org/iso/19115/-3/gco/1.0"/>
    <sch:ns uri="http://www.isotc211.org/2005/gmi" prefix="gmi"/>
    <sch:ns uri="http://www.isotc211.org/2005/gmd" prefix="gmd"/>
    
    <sch:ns uri="http://www.w3.org/1999/xlink" prefix="xlink"/>
    <sch:ns uri="http://www.opengis.net/gml/3.2" prefix="gml"/>
    <sch:ns uri="http://www.w3.org/2001/XMLSchema-instance" prefix="xsi"/>
    <sch:ns uri="http://www.isotc211.org/2005/gmx" prefix="gmx"/>
    <sch:ns uri="http://www.isotc211.org/2005/gfc" prefix="gfc"/>
    
    
    <sch:pattern>
        <!-- Change the attribute to point the element being the context of the assert expression. -->
        <!-- Shapefile or string(contains(.,'Relationship'))-->
        <sch:rule context="/gfc:FC_FeatureCatalogue/gmx:name[1]">
            <sch:let name="stringLength" value="string-length(.)"/>
            <sch:let name="FeatCatTest" value="string( contains(.,'Feature Catalog for the'))"/>
            <sch:let name="Year" value="string(contains(.,'2021'))"/> 
            <sch:let name="ShapeYesNo" value="string(contains(.,'Shapefile')) "/>
            <sch:let name="RelationshipYesNo" value="string(contains(.,'Relationship')) "/>
            <!-- Change the assert expression. -->
            <sch:assert test="$stringLength>12">EA_BasicCheck2.sch #1A: The filename is missing. It is <sch:value-of select="$stringLength"/></sch:assert>
            <sch:assert test="$FeatCatTest='true'">EA_BasicCheck2.sch #2: The file name must start with 'Feature Catalog for the'.<sch:value-of select="$FeatCatTest"/> </sch:assert>
            <sch:assert test="$Year='true'">EA_BasicCheck2.sch #3: The file name must contain '2021'.</sch:assert>
            <sch:assert test="$ShapeYesNo='true' or $RelationshipYesNo='true'" >EA_BasicCheck2.sch #4: The title should include or 'Shapefile' or 'Relationship' </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern>
        <sch:rule context="/gfc:FC_FeatureCatalogue/gmx:scope[1]">
            <sch:let name="ScopeStringLength" value="string-length(.)"/>
            <sch:assert test="$ScopeStringLength>12">EA_BasicCheck2.sch #4: The scope is missing.</sch:assert>  
        </sch:rule>
    </sch:pattern>
</sch:schema>
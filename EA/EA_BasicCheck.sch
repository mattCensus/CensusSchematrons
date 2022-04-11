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
        <sch:rule context="/gfc:FC_FeatureCatalogue/gmx:name[1]/gco:CharacterString[1]">
            <sch:let name="stringLength" value="string-length(.)"/>
            <!-- Change the assert expression. -->
            <sch:assert test="string-length(./gco:CharacterString[1])>10">EA_BasicCheck.sch #1: The filename is missing. It is <sch:value-of select="$stringLength"/></sch:assert>
            <sch:report  test="string-length(./gco:CharacterString[1])>10">EA_BasicCheck.sch #1: The filename is missing. It is <sch:value-of select="$stringLength"/></sch:report>
            <sch:assert test="contains(./gco:CharacterString[1],'Feature Catalog for the')">EA_BasicCheck.sch #2: The file name must start with 'Feature Catalog for the'.</sch:assert>
            <sch:assert test="contains(./gco:CharacterString[1],'2021')">EA_BasicCheck.sch #3: The file name must contain '2021'.</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern>
        <sch:rule context="/gfc:FC_FeatureCatalogue/gmx:scope[1]">
            <sch:assert test="string-length(./gco:CharacterString[1])>10">EA_BasicCheck.sch #4: The scope is missing.</sch:assert>  
        </sch:rule>
    </sch:pattern>
</sch:schema>
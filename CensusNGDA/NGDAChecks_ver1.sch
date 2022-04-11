<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
    <sch:ns prefix="dqm" uri="http://standards.iso.org/iso/19157/-2/dqm/1.0"/>
    <sch:ns prefix="cat" uri="http://standards.iso.org/iso/19115/-3/cat/1.0"/>
    <sch:ns prefix="cit" uri="http://standards.iso.org/iso/19115/-3/cit/1.0"/>
    <sch:ns prefix="mcc" uri="http://standards.iso.org/iso/19115/-3/mcc/1.0"/>
    <sch:ns prefix="gco" uri="http://standards.iso.org/iso/19115/-3/gco/1.0"/>
    <sch:ns uri="http://www.isotc211.org/2005/gmi" prefix="gmi"/>
    <sch:ns uri="http://www.isotc211.org/2005/gmd" prefix="gmd"/>
    
   
   
    
 <sch:pattern id="altTitle">
     <sch:rule context="gmi:MI_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation">
         <sch:assert test="count(gmd:alternateTitle)=1">The alternate title is missing</sch:assert>
         <sch:let name="altTitle" value="./gmd:alternateTitle/gco:CharacterString"/>
         <sch:let name="altTitleA" value="normalize-space,$altTitle"/>
         <!-- <sch:assert test="starts-with($altTitleA,'National Geospatial Data Asset')">The phrase "National Geospatial Data Asset" is missing from the beginning
             of the alternate title </sch:assert>
           -->
     </sch:rule>
 </sch:pattern>
    
   
   
</sch:schema>

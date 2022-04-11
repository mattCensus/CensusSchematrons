<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
    <sch:ns prefix="dqm" uri="http://standards.iso.org/iso/19157/-2/dqm/1.0"/>
    <sch:ns prefix="cat" uri="http://standards.iso.org/iso/19115/-3/cat/1.0"/>
    <sch:ns prefix="cit" uri="http://standards.iso.org/iso/19115/-3/cit/1.0"/>
    <sch:ns prefix="mcc" uri="http://standards.iso.org/iso/19115/-3/mcc/1.0"/>
    <sch:ns prefix="gco" uri="http://standards.iso.org/iso/19115/-3/gco/1.0"/>
    <sch:ns uri="http://www.isotc211.org/2005/gmi" prefix="gmi"/>
    <sch:ns uri="http://www.isotc211.org/2005/gmd" prefix="gmd"/>
    
   
   <!-- Checking the alternate title -->
    
    <!-- Making sure the alternate title exists -->
    <!-- This pattern works -->
    <sch:pattern id="altTitle">
     <sch:rule context="gmi:MI_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation">
         <sch:assert test="count(gmd:alternateTitle)=1">The alternate title is missing</sch:assert>
         <sch:let name="altTitle" value="./gmd:alternateTitle/gco:CharacterString"/>
         <sch:let name="altTitleA" value="normalize-space($altTitle)"/>
         <!-- <sch:assert test="starts-with($altTitleA,'National Geospatial Data Asset')">The phrase "National Geospatial Data Asset" is missing from the beginning
             of the alternate title </sch:assert>
           -->
     </sch:rule>
    </sch:pattern>
    
    <!-- Checking the keywords -->
    <!-- Making sure that there are 3 keywords -->
    <!-- This pattern works -->
    <sch:pattern>
        <sch:rule context="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:descriptiveKeywords[1]/gmd:MD_Keywords[1]">
            <sch:assert test="count(gmd:keyword)=3">There are supposed to be 3 keywords</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!-- Checking for both the WMS and REST URLS-->
    <!-- This pattern works -->
    <sch:pattern>
        <sch:rule context="/gmi:MI_Metadata/gmd:distributionInfo[1]/gmd:MD_Distribution[1]">
            <sch:assert test="count(gmd:transferOptions[3])">The WMS URL is missing!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!</sch:assert>
            <sch:assert test="count(gmd:transferOptions[4])">The REST URL is missing!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!-- Checking for WMS -->
    <!-- making sure that it exists -->
    <!-- This pattern works -->
     <sch:pattern>
        <sch:rule context="/gmi:MI_Metadata/gmd:distributionInfo[1]/gmd:MD_Distribution[1]/gmd:transferOptions[3]/gmd:MD_DigitalTransferOptions[1]/gmd:onLine[1]/gmd:CI_OnlineResource[1]">
            <sch:assert test="count(.)=1">The WMS URL is missing!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! </sch:assert>
            <sch:assert test="count(gmd:linkage)=1">The WMS URL is missing!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!</sch:assert>
            <sch:assert test="count(gmd:applicationProfile)=1">The application profile is missing for the WMS URL </sch:assert>
            <sch:assert test="count(gmd:name)=1"> The name is missing for WMS URL</sch:assert>
            <sch:assert test="count(gmd:description)=1">The description is missing for the WMS URL</sch:assert>
            <sch:assert test="count(gmd:function)=1">The function is missing for the WMS URL</sch:assert>
        </sch:rule>
     </sch:pattern> 
    
    <!-- Checking for REST-->
    <!-- making sure that it exists -->
    <!-- This pattern works -->
    <sch:pattern>
        <sch:rule context="/gmi:MI_Metadata/gmd:distributionInfo[1]/gmd:MD_Distribution[1]/gmd:transferOptions[4]/gmd:MD_DigitalTransferOptions[1]/gmd:onLine[1]/gmd:CI_OnlineResource[1]">
            <sch:assert test="count(.)=1">The REST URL is missing!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! </sch:assert>
            <sch:assert test="count(gmd:linkage)=1">The REST URL is missing!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!</sch:assert>
            <sch:assert test="count(gmd:applicationProfile)=1">The application profile is missing for the REST URL </sch:assert>
            <sch:assert test="count(gmd:name)=1"> The name is missing for REST URL</sch:assert>
            <sch:assert test="count(gmd:description)=1">The description is missing for the REST URL</sch:assert>
            <sch:assert test="count(gmd:function)=1">The function is missing for the REST URL</sch:assert>
        </sch:rule>
    </sch:pattern> 
    
    
    
    
    
    
    
    
    
    
     <!-- <sch:pattern>
       
   </sch:pattern> 
    <sch:pattern id="ngdaCountLength1">
        <sch:rule
            context="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:descriptiveKeywords[1]/gmd:MD_Keywords[1]/gmd:keyword[1]/gco:CharacterString[1]">
            <sch:assert test="string-length(.)=4">The first keyword must be 'NGDA' string length</sch:assert>
        </sch:rule>
    </sch:pattern>
    
   <sch:pattern id="ngdaKeywordsContains1">
       <sch:rule
           context="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:descriptiveKeywords[1]/gmd:MD_Keywords[1]/gmd:keyword[1]/gco:CharacterString[1]">
           <sch:assert test="starts-with(.,'NGDA')">The first keyword must be 'NGDA'</sch:assert>
       </sch:rule>
   </sch:pattern> -->
   
</sch:schema>

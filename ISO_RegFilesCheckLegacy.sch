<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
    <sch:ns prefix="dqm" uri="http://standards.iso.org/iso/19157/-2/dqm/1.0"/>
    <sch:ns prefix="cat" uri="http://standards.iso.org/iso/19115/-3/cat/1.0"/>
    <sch:ns prefix="cit" uri="http://standards.iso.org/iso/19115/-3/cit/1.0"/>
    <sch:ns prefix="mcc" uri="http://standards.iso.org/iso/19115/-3/mcc/1.0"/>
    <sch:ns prefix="gco" uri="http://standards.iso.org/iso/19115/-3/gco/1.0"/>
    <sch:ns uri="http://www.isotc211.org/2005/gmi" prefix="gmi"/>
    <sch:ns uri="http://www.isotc211.org/2005/gmd" prefix="gmd"/>
    
  <!--  <sch:pattern id="charactersetCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:characterSet[1]/gmd:MD_CharacterSetCode[1]">
            <sch:assert test="contains(./@codeListValue,'UTF-8')">The codelist value must be equal to 'UTF-8'</sch:assert>
            <sch:assert test="contains(./@codeSpace,'004')">The codespace value for gmd:MD_CharacterSetCode must be '004' </sch:assert>
        </sch:rule>
    </sch:pattern> --> 
    
    <sch:pattern>
        <!-- Change the attribute to point the element being the context of the assert expression. -->
        <sch:rule context="/gmi:MI_Metadata/gmd:dateStamp[1]/gco:Date[1]">
            <!-- Change the assert expression. -->
            <sch:assert test="contains(.,'2020')">Err#1: The year mustbe 2020.</sch:assert>
            
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern>
        <!-- Change the attribute to point the element being the context of the assert expression. -->
        <sch:rule context="//gmi:MI_Metadata/gmd:dataSetURI[1]/gco:CharacterString">
            <!-- Change the assert expression. -->
            <sch:assert test="starts-with(.,'https:')">The URL must contain 'https'</sch:assert>
        </sch:rule>
    </sch:pattern>


<sch:pattern>
    <sch:rule context="/gmi:MI_Metadata/gmd:distributionInfo[1]/gmd:MD_Distribution[1]/gmd:transferOptions[1]/gmd:MD_DigitalTransferOptions[1]/gmd:onLine[1]/gmd:CI_OnlineResource[1]">
        <sch:assert test="contains(./gmd:linkage[1]/gmd:URL[1],'.zip')">
            The download file should contain '.zip'!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        </sch:assert>
        <sch:assert test="contains(./gmd:linkage[1]/gmd:URL[1],'https')">
            The download file should contain 'https'!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        </sch:assert>
        <!--   <sch:assert test="contains(./gmd:name[1]/gco:CharacterString[1],'Shapefile')">
                The download file should contain 'https'
            </sch:assert>-->
    </sch:rule>
</sch:pattern>
    
 <sch:pattern id="EACheck">
     <sch:rule context="/gmi:MI_Metadata/gmd:contentInfo[1]/gmd:MD_FeatureCatalogueDescription[1]/gmd:featureCatalogueCitation[1]/gmd:CI_Citation[1]/gmd:otherCitationDetails[1]/gco:CharacterString">
         <sch:assert test="contains(normalize-space(.),'TIGER2013')">The URL should contain TIGER2013</sch:assert>
         <sch:let name="EAValue" value="."></sch:let>
         <sch:let name="EaTest" value="contains(.,'TIGER2013')"/>
         <sch:assert test="$EaTest= True">The URL should contain TIGER2013 <sch:value-of select="$EaTest"/> <sch:value-of select="$EAValue"/>.....</sch:assert>
     </sch:rule>
 </sch:pattern>




</sch:schema>
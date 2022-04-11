<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
    <sch:ns prefix="dqm" uri="http://standards.iso.org/iso/19157/-2/dqm/1.0"/>
    <sch:ns prefix="cat" uri="http://standards.iso.org/iso/19115/-3/cat/1.0"/>
    <sch:ns prefix="cit" uri="http://standards.iso.org/iso/19115/-3/cit/1.0"/>
    <sch:ns prefix="mcc" uri="http://standards.iso.org/iso/19115/-3/mcc/1.0"/>
    <sch:ns prefix="gco" uri="http://standards.iso.org/iso/19115/-3/gco/1.0"/>
    <sch:ns uri="http://www.isotc211.org/2005/gmi" prefix="gmi"/>
    <sch:ns uri="http://www.isotc211.org/2005/gmd" prefix="gmd"/>
    
    <sch:pattern id="charactersetCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:characterSet[1]/gmd:MD_CharacterSetCode[1]">
            <sch:assert test="contains(./@codeListValue,'UTF-8')">ISO_RegFilesCheckNational.sch err#1: The codelist value must be equal to 'UTF-8'</sch:assert>
            <sch:assert test="contains(./@codeSpace,'004')">ISO_RegFilesCheckNational.sch err#2: The codespace value for gmd:MD_CharacterSetCode must be '004' </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern>
        <!-- Change the attribute to point the element being the context of the assert expression. -->
        <sch:rule context="//gmi:MI_Metadata/gmd:dataSetURI[1]/gco:CharacterString">
            <!-- Change the assert expression. -->
            <sch:assert test="starts-with(.,'https:')">ISO_RegFilesCheckNational.sch err#3: The URL must contain 'https'</sch:assert>
        </sch:rule>
    </sch:pattern>

<!-- checking for the correct place keywords -->
    <sch:pattern>
        <sch:rule context="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:descriptiveKeywords[2]/gmd:MD_Keywords[1]">
            <!--  <sch:assert test="contains(./gmd:thesaurusName[1]/gmd:CI_Citation[1]/gmd:title[1]/gco:CharacterString[1],'3166')">
                The value for the thesauraus should be 'ISO 3166 Codes for the representation of names of countries and their subdivisions'
                </sch:assert> 
                <sch:assert test="starts-with(./gmd:thesaurusName[1]/gmd:CI_Citation[1]/gmd:title[1]/gco:CharacterString[1],'ISO')"></sch:assert>-->
            <sch:assert test="matches(normalize-space(.),'ISO 3166')">ISO_RegFilesCheckNational.sch err#4: The value for the thesauraus should be 'ISO 3166 Codes for the representation of names of countries and their subdivisions' </sch:assert>
        </sch:rule>
    </sch:pattern>
    

<sch:pattern>
    <sch:rule context="/gmi:MI_Metadata/gmd:distributionInfo[1]/gmd:MD_Distribution[1]/gmd:transferOptions[1]/gmd:MD_DigitalTransferOptions[1]/gmd:onLine[1]/gmd:CI_OnlineResource[1]">
        <sch:assert test="contains(./gmd:linkage[1]/gmd:URL[1],'.zip')">
            ISO_RegFilesCheckNational.sch err#5: The download file should contain '.zip'!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        </sch:assert>
        <sch:assert test="contains(./gmd:linkage[1]/gmd:URL[1],'https')">
            ISO_RegFilesCheckNational.sch err#6: The download file should contain 'https'!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        </sch:assert>
        <!--   <sch:assert test="contains(./gmd:name[1]/gco:CharacterString[1],'Shapefile')">
                The download file should contain 'https'
            </sch:assert>-->
    </sch:rule>
</sch:pattern>
    
    <sch:pattern>
        <sch:rule context="/gmi:MI_Metadata/gmd:distributionInfo[1]/gmd:MD_Distribution[1]/gmd:transferOptions[2]/gmd:MD_DigitalTransferOptions[1]/gmd:onLine[1]/gmd:CI_OnlineResource[1]/gmd:linkage[1]/gmd:URL[1]">
            <sch:assert test="contains(./gmd:linkage[1]/gmd:URL[1],'https')">
                ISO_RegFilesCheckNational.sch err#7: The TIGER\Line directory URL should contain 'https'!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
 <sch:pattern id="EACheck">
     <sch:rule context="/gmi:MI_Metadata/gmd:contentInfo[1]/gmd:MD_FeatureCatalogueDescription[1]/gmd:featureCatalogueCitation[1]/gmd:CI_Citation[1]/gmd:otherCitationDetails[1]">
         <sch:assert test="contains(normalize-space(./gco:CharacterString),'TIGER2020')">ISO_RegFilesCheckNational.sch err#8: The download directory for the EA download should contian "TIGER2020"</sch:assert>
     </sch:rule>
 </sch:pattern>




</sch:schema>
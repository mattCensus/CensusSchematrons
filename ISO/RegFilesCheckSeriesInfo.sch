<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
    <sch:ns prefix="dqm" uri="http://standards.iso.org/iso/19157/-2/dqm/1.0"/>
    <sch:ns prefix="cat" uri="http://standards.iso.org/iso/19115/-3/cat/1.0"/>
    <sch:ns prefix="cit" uri="http://standards.iso.org/iso/19115/-3/cit/1.0"/>
    <sch:ns prefix="mcc" uri="http://standards.iso.org/iso/19115/-3/mcc/1.0"/>
    <sch:ns prefix="gco" uri="http://standards.iso.org/iso/19115/-3/gco/1.0"/>
    <sch:ns uri="http://www.isotc211.org/2005/gmi" prefix="gmi"/>
    <sch:ns uri="http://www.isotc211.org/2005/gmd" prefix="gmd"/>
    
   <!-- checking to make sure that the codelist value and characterset are correct -->
    
    <sch:pattern id="charactersetCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:characterSet[1]/gmd:MD_CharacterSetCode[1]">
            <sch:assert test="contains(./@codeListValue,'UTF-8')">RegFilesCheckSeriesInfo.sch err#1: The codelist value must be equal to 'UTF-8'</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    
    
  <!--   <sch:pattern id="browseGraphicCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:graphicOverview[1]/gmd:MD_BrowseGraphic[1]">
            <sch:assert test="contains(./gmd:fileName[1]/gco:CharacterString[1],'https')">The browse graphic should contain 'https'</sch:assert>
        </sch:rule>
    </sch:pattern> -->
    
    <!-- checking for the correct place keywords -->
    <sch:pattern>
        <sch:rule context="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:descriptiveKeywords[2]/gmd:MD_Keywords[1]">
            <!--  <sch:assert test="contains(./gmd:thesaurusName[1]/gmd:CI_Citation[1]/gmd:title[1]/gco:CharacterString[1],'3166')">
                The value for the thesauraus should be 'ISO 3166 Codes for the representation of names of countries and their subdivisions'
                </sch:assert> 
                <sch:assert test="starts-with(./gmd:thesaurusName[1]/gmd:CI_Citation[1]/gmd:title[1]/gco:CharacterString[1],'ISO')"></sch:assert>-->
            <sch:assert test="matches(normalize-space(.),'ISO 3166')">RegFilesCheckSeriesInfo.sch err#2: The value for the thesauraus should be 'ISO 3166 Codes for the representation of names of countries and their subdivisions' </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern>
        <sch:rule context="/gmi:MI_Metadata/gmd:contentInfo[1]/gmd:MD_FeatureCatalogueDescription[1]/gmd:featureCatalogueCitation[1]/gmd:CI_Citation[1]/gmd:otherCitationDetails[1]">
            <sch:assert test="matches(normalize-space(./gco:CharacterString),'TIGER2017')">RegFilesCheckSeriesInfo.sch err#3: Make sure the file is contains the "TIGER2017" directory</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!--Checking for the zip file    -->
    <sch:pattern>
        <sch:rule context="/gmi:MI_Metadata/gmd:distributionInfo[1]/gmd:MD_Distribution[1]/gmd:transferOptions[1]/gmd:MD_DigitalTransferOptions[1]/gmd:onLine[1]/gmd:CI_OnlineResource[1]">
            <sch:report test="contains(./gmd:linkage[1]/gmd:URL[1],'.zip')">RegFilesCheckSeriesInfo.sch err#4: There should not be a zip file for the download</sch:report>
            <sch:assert test="contains(./gmd:linkage[1]/gmd:URL[1],'https://www2.census.gov/geo/tiger/TIGER2020PL/LAYER')">RegFilesCheckSeriesInfo.sch err#5: The file's download URL should have 'https://www2.census.gov/geo/tiger/TIGER2020PL/LAYER'</sch:assert>
            <!--  <sch:assert test="contains(./gmd:linkage[1]/gmd:URL[1],'.zip')">
                The download file should contain '.zip'!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
            </sch:assert>-->
                       <!--   <sch:assert test="contains(./gmd:name[1]/gco:CharacterString[1],'Shapefile')">
                The download file should contain Shapefile Zip File
            </sch:assert>-->
        </sch:rule>
    </sch:pattern>
    
    <!-- checking for the correct URL for the TIGER page -->
    <sch:pattern id="TIGERCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:distributionInfo[1]/gmd:MD_Distribution[1]/gmd:transferOptions[2]/gmd:MD_DigitalTransferOptions[1]/gmd:onLine[1]/gmd:CI_OnlineResource[1]">
            <sch:assert test="contains(./gmd:linkage[1]/gmd:URL[1],'https')">RegFilesCheckSeriesInfo.sch err#6: The TIGER shapefiles page is incorrect. It should be 'https://www.census.gov/geo/maps-data/data/tiger-line.html'</sch:assert>
            <sch:report test="contains(./gmd:name[1]/gco:CharacterString[1],'&#174;')">RegFilesCheckSeriesInfo.sch err#7: Remove the ® and replace it with &#174; !!!!!!!!</sch:report>
        </sch:rule>
        
    </sch:pattern>
    
   
</sch:schema>

<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
    <sch:ns prefix="dqm" uri="http://standards.iso.org/iso/19157/-2/dqm/1.0"/>
    <sch:ns prefix="cat" uri="http://standards.iso.org/iso/19115/-3/cat/1.0"/>
    <sch:ns prefix="cit" uri="http://standards.iso.org/iso/19115/-3/cit/1.0"/>
    <sch:ns prefix="mcc" uri="http://standards.iso.org/iso/19115/-3/mcc/1.0"/>
    <sch:ns prefix="gco" uri="http://standards.iso.org/iso/19115/-3/gco/1.0"/>
    <sch:ns uri="http://www.isotc211.org/2005/gmi" prefix="gmi"/>
    <sch:ns uri="http://www.isotc211.org/2005/gmd" prefix="gmd"/>
    <sch:ns uri="http://www.opengis.net/gml/3.2" prefix="gml"/>
    
    <sch:let name="SeriesInfo" value="/gmi:MI_Metadata/gmd:parentIdentifier[1]"/>
    <sch:let name="SeriesInfoPostFor" value="substring-after($SeriesInfo,'for the ')"/>
    <sch:let name="ParentTheme" value="substring-after($SeriesInfo,'for the ')"/>
    <sch:let name="ParentTheme2" value="normalize-space($ParentTheme)"></sch:let>
    
    <sch:let name="Title" value="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:citation[1]/gmd:CI_Citation[1]/gmd:title[1]"/>
    <sch:let name="Title2" value="substring-after($Title,',')"/>
    <sch:let name="Title3" value="substring-after($Title2,',')"/>
    <sch:let name="Title4" value="substring-after($Title3,',')"/>
    <sch:let name="Title5" value="substring-after($Title4,',')"/>
    <sch:let name="Title6" value="substring-after($Title5,', ')"/>
    <sch:let name="Title7" value="normalize-space($Title6)"/>
    
    
    <sch:let name="NetResName" value="/gmi:MI_Metadata/gmd:distributionInfo[1]/gmd:MD_Distribution[1]/gmd:transferOptions[1]/gmd:MD_DigitalTransferOptions[1]/gmd:onLine[1]/gmd:CI_OnlineResource[1]/gmd:linkage[1]/gmd:URL[1]"/>
    <sch:let name="NetResNameTheme" value="substring-after($NetResName,'TIGER2020/')"/>
    <sch:let name="NetResNameTheme2" value="substring-before($NetResNameTheme,'/')"/>
    
    <sch:let name="MetFileId" value="/gmi:MI_Metadata/gmd:fileIdentifier[1]/gco:CharacterString[1]"/>
    <sch:let name="MetFileId2" value="substring-after($MetFileId,'2020_')"/>
    <sch:let name="MetFileId3" value="substring-before($MetFileId2,'.')"/>
    <sch:let name="MetFileId4" value="upper-case($MetFileId3)"/>
    <sch:let name="MetFileId5" value="translate($MetFileId3,'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
    
    <sch:pattern id="charactersetCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:characterSet[1]/gmd:MD_CharacterSetCode[1]">
            <sch:assert test="contains(./@codeListValue,'UTF-8')">ISO_RegCounties.sch #1: The codelist value must be equal to 'UTF-8'</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id="metadataDateCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:dateStamp[1]/gco:Date">
            <sch:let name="yearA" value="."/>
            <sch:assert test="$yearA = '2020'" >ISO_RegCounties.sch #2: The year must be 2020. It is currently:    <sch:value-of select="$yearA"/></sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id="CodeIdentifierCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:citation[1]/gmd:CI_Citation[1]">
            <sch:assert test="count(./gmd:identifier)=1">ISO_RegCounties.sch #3: The code identifier location is missing</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id="identifierCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:citation[1]/gmd:CI_Citation[1]/gmd:identifier[1]/gmd:MD_Identifier[1]/gmd:code[1]/gco:CharacterString">
            <sch:assert test="count(.)=1">ISO_RegCounties.sch #4: The code identifier location is missing</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id="RootElementsCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:fileIdentifier[1]/gco:CharacterString[1]">
            <sch:assert test="count(.)=1">ISO_RegCounties.sch #5: The fileIdentifier is missing. </sch:assert>
            <sch:assert test="string-length(.)>15">ISO_RegCounties.sch #6: The filename is to short. Make sure the complete filename is there</sch:assert>
            <sch:assert test="contains(.,'.shp.iso.xml')">ISO_RegCounties.sch #7: The filename must contain .shp.iso.xml </sch:assert>
            <sch:assert test="contains(.,'tl_2020')">ISO_RegCounties.sch #8 The filename must contain 'tl_2020'</sch:assert>
        </sch:rule>
    </sch:pattern>
    
   <!--  /gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:descriptiveKeywords[3]
   /gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:descriptiveKeywords[2]
  /gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:descriptiveKeywords[4]
   
   -->
    <sch:pattern id="ISO3166CheckStates">
        <sch:rule context="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:descriptiveKeywords[3]/gmd:MD_Keywords[1]">
            <!--  <sch:assert test="contains(./gmd:thesaurusName[1]/gmd:CI_Citation[1]/gmd:title[1]/gco:CharacterString[1],'3166')">
                The value for the thesauraus should be 'ISO 3166 Codes for the representation of names of countries and their subdivisions'
                </sch:assert> /gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:descriptiveKeywords[4]
                <sch:assert test="starts-with(./gmd:thesaurusName[1]/gmd:CI_Citation[1]/gmd:title[1]/gco:CharacterString[1],'ISO')"></sch:assert>-->
            <sch:let name="PlaceThes" value="string-length(.)"/>
            <sch:assert test="matches(normalize-space(.),'38-2009')">ISO_RegCounties.sch #5: The value for the thesauraus should be 'National Standard Codes (ANSI INCITS 38-2009), Federal Information Processing Series (FIPS) – States/State Equivalents' </sch:assert>
            <sch:assert test="$PlaceThes  &lt; 529">ISO_RegCounties.sch #6: Make Sure the value for the Place Thesaurus is correct <sch:value-of select="$PlaceThes"/></sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!-- checking for the correct URL for the TIGER page -->
    <sch:pattern id="TIGERCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:distributionInfo[1]/gmd:MD_Distribution[1]/gmd:transferOptions[2]/gmd:MD_DigitalTransferOptions[1]/gmd:onLine[1]/gmd:CI_OnlineResource[1]">
            <sch:assert test="contains(./gmd:linkage[1]/gmd:URL[1],'https')">ISO_RegCounties.sch #7: The TIGER shapefiles page is incorrect. It should be 'https://www.census.gov/geo/maps-data/data/tiger-line.html'</sch:assert>
            <sch:report test="contains(./gmd:name[1]/gco:CharacterString[1],'&#174;')">ISO_RegCounties.sch #8: Remove the ® and replace it with &#174; !!!!!!!!</sch:report>
        </sch:rule>
    </sch:pattern>
    
   
    
    <sch:pattern id="URLDownloadCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:distributionInfo[1]/gmd:MD_Distribution[1]/gmd:transferOptions[1]/gmd:MD_DigitalTransferOptions[1]/gmd:onLine[1]/gmd:CI_OnlineResource[1]">
            <sch:assert test="count(gmd:linkage)=1">ISO_RegCounties.sch #9: The linkage URL for the download URL is missing.</sch:assert>
            <sch:assert test="count(gmd:applicationProfile)=1">ISO_RegCounties.sch #10: The gmd:applicationProfile element for the download URL is missing. </sch:assert>
            <sch:assert test="count(gmd:name)=1">ISO_RegCounties.sch #11: The gmd:name element for the download URL is missing. </sch:assert>
            <sch:assert test="count(gmd:description)=1">ISO_RegCounties.sch #12: The gmd:description element for the download URL is missing.</sch:assert>
            <sch:assert test="count(gmd:function)=1">ISO_RegCounties.sch #13: The gmd:function element for the download URL is missing.</sch:assert>
            <sch:assert test="contains(./gmd:linkage[1]/gmd:URL[1],'https')">ISO_RegCounties.sch #14: The linkage for the download URL does not contains https</sch:assert>
            <sch:assert test="contains(./gmd:linkage[1]/gmd:URL[1],'.zip')">ISO_RegCounties.sch #15: The download file for the download URL must contain '.zip'</sch:assert>
            <sch:report test="contains(./gmd:description[1],'C:/Users')">ISO_RegCounties.sch err#16: This should not contain "C:/Users" </sch:report>
            <sch:let name="descriptionLength" value="string-length(./gmd:description[1]/gco:CharacterString[1])"/>
            <sch:report test="$descriptionLength>1">ISO_RegCounties.sch err#17: The string lenght is  <sch:value-of select="$descriptionLength"/></sch:report>
            <sch:report test="contains(./gmd:function[1]/gmd:CI_OnLineFunctionCode[1]/@codeListValue,'download!!')">ISO_RegCounties.sch err#18:  This attribute should not contain !!!</sch:report>
        </sch:rule>
        
    </sch:pattern>
    
    <sch:pattern id="EATitleCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:contentInfo[1]/gmd:MD_FeatureCatalogueDescription[1]/gmd:featureCatalogueCitation[1]/gmd:CI_Citation[1]/gmd:title[1]">
            <sch:let name="stringLength" value="string-length(.)"/>
            <sch:let name="FeatCatTest" value="string( contains(.,'Feature Catalog for the'))"/>
            <sch:let name="Year" value="string(contains(.,'2020'))"/> 
            <sch:let name="ShapeYesNo" value="string(contains(.,'Shapefile'))"/>
            <!-- Change the assert expression. -->
            <sch:assert test="$stringLength>12">ISO_RegCounties.sch #19: The filename is missing. It is <sch:value-of select="$stringLength"/></sch:assert>
            <sch:assert test="$FeatCatTest='true'">ISO_RegCounties.sch #20: The file name must start with 'Feature Catalog for the'.<sch:value-of select="$FeatCatTest"/> </sch:assert>
            <sch:assert test="$Year='true'">IISO_RegCounties.sch #21: The file name must contain '2020'.</sch:assert>
            <sch:assert test="$ShapeYesNo='true'">ISO_RegCounties.sch #22: The title should include "Shapefile'</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id="EAOtherCitationCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:contentInfo[1]/gmd:MD_FeatureCatalogueDescription[1]/gmd:featureCatalogueCitation[1]/gmd:CI_Citation[1]/gmd:otherCitationDetails[1]">
            <sch:let name="TLYear" value="string(contains(.,'tl_2020'))"/> 
            <sch:let name="TLDir" value="string(contains(.,'TIGER2020'))"></sch:let>
            <sch:assert test="$TLYear='true'">ISO_RegCounties.sch #23: The URL must contain 'tl_2020'.</sch:assert>
            <sch:assert test="$TLDir='true'">ISO_RegCounties.sch #24: The directory must be 'TIGER2020'.It is <sch:value-of select="$TLDir"/> </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id="TIGERTitleCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:citation[1]/gmd:CI_Citation[1]/gmd:title[1]">
            <sch:let name="TIGERLineYes" value="string(contains(.,'TIGER/Line Shapefile'))"/>
            <sch:assert test="$TIGERLineYes ='true'">ISO_RegCounties.sch #25: The main title should include 'TIGER/Line Shapefile'</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id="editionCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:citation[1]/gmd:CI_Citation[1]/gmd:edition[1]">
            <sch:let name="Year" value="string(contains(.,'2020'))"/> 
            <sch:assert test="$Year='true'">ISO_RegCounties.sch #26: The edition name must contain '2020'.</sch:assert>
        </sch:rule>
    </sch:pattern> 
    
    <sch:pattern id="timeperiodcheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:extent[1]/gmd:EX_Extent[1]">
            <sch:assert test="count(./gmd:geographicElement)=1">ISO_RegCounties.sch #27: The bounding coordinates are missing</sch:assert>
            <sch:assert test="count(./gmd:temporalElement)=1">ISO_RegCounties.sch #28: The timeperiod is missing</sch:assert>
            <sch:let name="beginYear" value="string(contains(./gmd:temporalElement[1]/gmd:EX_TemporalExtent[1]/gmd:extent[1]/gml:TimePeriod[1]/gml:beginPosition[1],'2019'))"/>
            <sch:let name="endYear" value="string(contains(./gmd:temporalElement[1]/gmd:EX_TemporalExtent[1]/gmd:extent[1]/gml:TimePeriod[1]/gml:endPosition[1],'2020'))"/> 
            <sch:assert test="$beginYear='true'">ISO_RegCounties.sch #29: The beginning year must be '2019'</sch:assert>
            <sch:assert test="$endYear='true'">ISO_RegCounties.sch #30: The ending year must be '2020'</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id='boundingBoxCheck'>
        <sch:title>EX_GeographicBoundingBox</sch:title>
        <sch:rule context="//gmd:EX_GeographicBoundingBox">      
            <sch:assert test="not(gmd:westBoundLongitude/gco:Decimal &lt; -180)">ISO_RegCounties.sch #31: West Bounding Longitude must be -180 or greater</sch:assert>
            <sch:assert test="not(gmd:westBoundLongitude/gco:Decimal &gt; 180)">IISO_RegCounties.sch #32: West Bounding Longitude must be 180 or less</sch:assert>
            <sch:assert test="not(gmd:eastBoundLongitude/gco:Decimal &lt; -180)">ISO_RegCounties.sch #32: East Bounding Longitude must be -180 or greater</sch:assert>
            <sch:assert test="not(gmd:eastBoundLongitude/gco:Decimal &lt; -180)">ISO_RegCounties.sch #34: East Bounding Longitude must be -180 or greater</sch:assert>
            <sch:assert test="not(gmd:southBoundLatitude/gco:Decimal &lt; -90)">ISO_RegCounties.sch #35: South Bounding Latitude must be -90 or greater</sch:assert>
            <sch:assert test="not(gmd:southBoundLatitude/gco:Decimal &gt; 90)">ISO_RegCounties.sch #36:  South Bounding Latitude must be 90 or less</sch:assert>
            <sch:assert test="not(gmd:northBoundLatitude/gco:Decimal &lt; -90)">ISO_NGDACounties.sch #37: North Bounding Latitude must be -90 or greater</sch:assert>
            <sch:assert test="not(gmd:northBoundLatitude/gco:Decimal &gt; 90)">ISO_NGDACounties.sch #38:  North Bounding Latitude must be 90 or less</sch:assert>
            <!--  -->
            <!-- <assert test="gmd:westBoundLongitude/gco:Decimal &lt; gmd:eastBoundLongitude/gco:Decimal">westBoundLongitude must be less than eastBoundLongitude</assert>
      <assert test="gmd:northBoundLatitude/gco:Decimal &gt; gmd:southBoundLatitude/gco:Decimal">northBoundLatitude must be greater than southBoundLatitude</assert>-->
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id ='otherRestrictionCheck'>
        <sch:title>other restrictions in MD_LegalConstraints</sch:title>
        <sch:rule context="//gmd:MD_LegalConstraints">
            <sch:report test="gmd:accessConstraints/gmd:MD_RestrictionCode/@codeListValue='otherRestrictions' and not(gmd:otherConstraints)">ISO_RegCounties.sch #39: If gmd:accessConstraints has a gmd:MD_RestrictionCode with a value of 'otherRestrictions' then gmd: otherConstraints must be documented.</sch:report>
            <sch:report test="gmd:useConstraints/gmd:MD_RestrictionCode/@codeListValue='otherRestrictions' and not(gmd:otherConstraints)">ISO_RegCounties.sch #40: If gmd:useConstraints has a gmd:MD_RestrictionCode with a value of 'otherRestrictions' then gmd: otherConstraints must be documented.</sch:report>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id='MdDistributionCheck'>
        <sch:title>gmd:MD_Distribution</sch:title>
        <sch:rule context="//gmd:MD_Distribution">
            <sch:assert test="count(gmd:distributionFormat)&gt;0 or count(gmd:distributor/gmd:MD_Distributor/gmd:distributorFormat)&gt;0">ISO_RegCounties.sch #39: You must provide either gmd:distributionFormat or gmd:distributorFormat.</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id="datasourcecheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:dataQualityInfo[1]/gmd:DQ_DataQuality[1]/gmd:lineage[1]/gmd:LI_Lineage[1]/gmd:source[1]/gmd:LI_Source[1]/gmd:sourceExtent[1]/gmd:EX_Extent[1]">
            <sch:let name="beginYear" value="string(contains(./gmd:temporalElement[1]/gmd:EX_TemporalExtent[1]/gmd:extent[1]/gml:TimePeriod[1]/gml:beginPosition[1],'2019'))"/>
            <sch:let name="endYear" value="string(contains(./gmd:temporalElement[1]/gmd:EX_TemporalExtent[1]/gmd:extent[1]/gml:TimePeriod[1]/gml:endPosition[1],'2020'))"/> 
            <sch:assert test="$beginYear='true'">ISO_RegCounties.sch #41: The beginning year must be '2019'</sch:assert>
            <sch:assert test="$endYear='true'">ISO_RegCounties.sch #42: The ending year must be '2020'</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id="fileId">
        <sch:rule context="/gmi:MI_Metadata/gmd:fileIdentifier[1]">
            <sch:let name="fileStringLength" value="string-length(.)"></sch:let>
            <sch:assert test="string-length(.)>23">ISO_RegCounties.sch #43: The file id is not complete. Please fill it out.</sch:assert> 
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id='datasetCheck'>
        <sch:rule context="/gmi:MI_Metadata/gmd:hierarchyLevel[1]/gmd:MD_ScopeCode[1]/@codeListValue">
            <sch:let name="hierlevel" value="."/>
            <sch:assert test=".='dataset'">ISO_RegCounties.sch #44: The hierarchy level must be 'dataset' </sch:assert>
            
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id='datasetBoundingBoxCheck'>
        <sch:title>gmd:MD_DataIdentification Extent</sch:title>
        <sch:rule context="//gmd:MD_DataIdentification">
            <sch:report test="(not(gmd:hierarchyLevel) or gmd:hierarchyLevel/gmd:MD_ScopeCode/@codeListValue='dataset') and (count(//gmd:MD_DataIdentification/gmd:extent/*/gmd:geographicElement/gmd:EX_GeographicBoundingBox) + count (//gmd:MD_DataIdentification/gmd:extent/*/gmd:geographicElement/gmd:EX_GeographicDescription)) =0">
                ISO_RegCounties.sch #45: If the metadata gmd:hierarchyLevel code = 'dataset' then you must document gmd:EX_GeographicBoundingBox or gmd:EX_GeographicDescription.</sch:report>
        </sch:rule>
    </sch:pattern>
    
    <!-- /gmi:MI_Metadata/gmd:dataSetURI[1]/gco:CharacterString[1] -->
    
    <sch:pattern id='datasetURICheck'>
        <sch:rule context="/gmi:MI_Metadata/gmd:dataSetURI[1]">
            <sch:assert  test="contains(.,'https')">ISO_RegCounties.sch #46: The URL should contain 'https'</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id='datasetURICheck2'>
        <!-- Change the attribute to point the element being the context of the assert expression. -->
        <sch:rule context="//gmi:MI_Metadata/gmd:dataSetURI[1]/gco:CharacterString">
            <!-- Change the assert expression. -->
            <sch:assert test="starts-with(.,'https:')">ISO_RegCounties.sch #47: The URL must contain 'https'</sch:assert>
        </sch:rule>
    </sch:pattern>



<sch:pattern id='downloadcheck'>
    <sch:rule context="/gmi:MI_Metadata/gmd:distributionInfo[1]/gmd:MD_Distribution[1]/gmd:transferOptions[1]/gmd:MD_DigitalTransferOptions[1]/gmd:onLine[1]/gmd:CI_OnlineResource[1]">
        <sch:assert test="contains(./gmd:linkage[1]/gmd:URL[1],'.zip')">
            ISO_RegCounties.sch #48: The download file should contain '.zip'!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        </sch:assert>
        <sch:assert test="contains(./gmd:linkage[1]/gmd:URL[1],'https')">
            ISO_RegCounties.sch #49: The download file should contain 'https'!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        </sch:assert>
        <!--   <sch:assert test="contains(./gmd:name[1]/gco:CharacterString[1],'Shapefile')">
                The download file should contain 'https'
            </sch:assert>-->
        <sch:assert test="count(gmd:linkage)=1">ISO_RegCounties.sch #50: The linkage URL is missing.</sch:assert>
        <sch:assert test="count(gmd:applicationProfile)=1">ISO_RegCounties.sch #51: The gmd:applicationProfile element is missing. </sch:assert>
        <sch:assert test="count(gmd:name)=1">ISO_RegCounties.sch #51: The gmd:name element is missing. </sch:assert>
        <sch:assert test="count(gmd:description)=1">ISO_RegCounties.sch #53: The gmd:description element is missing.</sch:assert>
        <sch:assert test="count(gmd:function)=1">ISO_RegCounties.sch #54: The gmd:function element is missing.</sch:assert>
    </sch:rule>
</sch:pattern>
    
    <sch:pattern>
        <sch:rule context="/gmi:MI_Metadata/gmd:contentInfo[1]/gmd:MD_FeatureCatalogueDescription[1]/gmd:featureCatalogueCitation[1]/gmd:CI_Citation[1]/gmd:title[1]">
            <sch:let name="stringLength" value="string-length(.)"/>
            <sch:let name="FeatCatTest" value="string( contains(.,'Feature Catalog for the'))"/>
            <sch:let name="Year" value="string(contains(.,'2020'))"/> 
            <sch:let name="ShapeYesNo" value="string(contains(.,'Shapefile') or contains(.,'Relationship File'))"/>
            <!-- Change the assert expression. -->
            <sch:assert test="$stringLength>12">ISO_RegCounties.sch #55:: The filename is missing. It is <sch:value-of select="$stringLength"/></sch:assert>
            <sch:assert test="$FeatCatTest='true'">ISO_RegCounties.sch #56: The file name must start with 'Feature Catalog for the'.<sch:value-of select="$FeatCatTest"/> </sch:assert>
            <sch:assert test="$Year='true'">ISO_RegCounties.sch #57:: The file name must contain '2020'.</sch:assert>
            <sch:assert test="$ShapeYesNo='true'">ISO_RegCounties.sch #58: The title should include "Shapefile' or 'Relationship File'</sch:assert>
        </sch:rule>
    </sch:pattern>

    <!-- /gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:descriptiveKeywords[4] -->
    <sch:pattern id='keywordsCheck'>
        <sch:rule context="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]">
            <sch:let name="KeywordCount" value="count(gmd:descriptiveKeywords)"></sch:let>
            <sch:assert test="count(gmd:descriptiveKeywords)=4"> ISO_RegCounties.sch #59:Make sure there are four sets of keywords, There are currently <sch:value-of select="$KeywordCount"/></sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <!-- /gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:descriptiveKeywords[4] -->
    <sch:pattern id="countyCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:descriptiveKeywords[2]/gmd:MD_Keywords[1]/gmd:thesaurusName[1]/gmd:CI_Citation[1]/gmd:title[1]">
            <sch:let name="countyFips" value="string(contains(.,'31-2009'))"/>
            <sch:assert test="$countyFips='true'">ISO_RegCounties.sch #60: The second set of keyword must contain 'ANSI INCITS 31-2009' for the value of the thesaurus. It must have county values </sch:assert>
        </sch:rule>
        
    </sch:pattern>
    
    <!-- /gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:descriptiveKeywords[4]
    /gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:descriptiveKeywords[4]/gmd:MD_Keywords[1]/gmd:thesaurusName[1]/gmd:CI_Citation[1]
    -->
    <sch:pattern id="stateCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:descriptiveKeywords[4]/gmd:MD_Keywords[2]/gmd:thesaurusName[1]/gmd:CI_Citation[1]/gmd:title[1]">
            <sch:let name="countyFips" value="string(contains(.,'38-2009'))"/>
            <sch:assert test="$countyFips='true'">ISO_RegCounties.sch #61: The second set of theme keywords must contain 'ANSI INCITS 38-2009' for the value of the thesaurus. It must have state values.</sch:assert>
        </sch:rule>
        
    </sch:pattern>
    
    <!-- /gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:descriptiveKeywords[5] -->
    <sch:pattern id="nationCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:descriptiveKeywords[5]/gmd:MD_Keywords[1]/gmd:thesaurusName[1]/gmd:CI_Citation[1]/gmd:title[1]">
            <sch:let name="countyFips" value="string(contains(.,'3166'))"/>
            <sch:assert test="$countyFips='true'">ISO_RegCounties.sch #62: The second set of counties must contain '38-2009' for the value of the thesaurus. It must have national values </sch:assert>
        </sch:rule>
        
    </sch:pattern>
    
   
    
    <sch:pattern id="StutusCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]">
            <sch:assert test="count(gmd:status)=1">ISO_RegCounties.sch #63: Please make sure that there is a status</sch:assert>
        </sch:rule>
    </sch:pattern>

<sch:pattern id='ParentFileCheck'>
    <sch:rule context="/gmi:MI_Metadata">
        
        <sch:assert test="$ParentTheme2 = $Title7">ISO_RegCounties.sch #64: The title theme (:<sch:value-of select="$Title7"/>: <sch:value-of select="string-length($Title7)"/> ) does not match the parent theme (:<sch:value-of select="$ParentTheme2"/>:  <sch:value-of select="string-length($ParentTheme2)"/> <sch:value-of select="string-length($ParentTheme)"/> ). The parent theme is (<sch:value-of select="$SeriesInfo"/>) </sch:assert>
    </sch:rule>
</sch:pattern>
    
  <sch:pattern id='countyKeywordeChecdk'>
      <sch:rule context="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:descriptiveKeywords[3]/gmd:MD_Keywords[1]/gmd:keyword[1]">
          <sch:assert test="not(contains(.,'Bad State:'))">ISO_RegCounties.sch #65: The keyword should contain "Bad State'</sch:assert>
      </sch:rule>
  </sch:pattern>

</sch:schema>
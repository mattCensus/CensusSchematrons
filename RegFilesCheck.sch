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
            <sch:assert test="contains(./@codeListValue,'UTF-8')">The codelist value must be equal to 'UTF-8'</sch:assert>
            <sch:assert test="contains(./@codeSpace,'004')">The codespace value for gmd:MD_CharacterSetCode must be '004' </sch:assert>
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
     <sch:rule context="/gmi:MI_Metadata/gmd:contentInfo[1]/gmd:MD_FeatureCatalogueDescription[1]/gmd:featureCatalogueCitation[1]/gmd:CI_Citation[1]">
         <sch:assert test="starts-with(./gmd:title[1]/gco:CharacterString[1],'Feature Catalog')">
             Please make sure the title for Entity and Attribute Information contains Feature Catalog
         </sch:assert>
         <sch:assert test="contains(normalize-space(./gmd:otherCitationDetails[1]),'TIGER2019')"></sch:assert>
     </sch:rule>
 </sch:pattern> 
    
     <!--<sch:pattern>
        <sch:title>Feature Catalogue Description</sch:title>
        <sch:rule context="/GPM/Entity_and_Attribute_Information">
            <sch:assert test="contains(./Detailed_Description[1]/Entity_Type[1]/Entity_Type_Label[1],'.shp')"></sch:assert>
            <sch:assert test="count(./Feature_Catalogue_Description) =1">There needs to be a Feature Catalogue Description</sch:assert>
            <sch:assert test="contains(./Feature_Catalogue_Description/FC_Title,'Shapefile')">The Feature Catalogue Description must contain Shapefile></sch:assert>
            <sch:assert test="contains(./Feature_Catalogue_Description/FC_Title,'Feature Catalog')">The Feature Catalogue Description must contain Feature Catalog</sch:assert>
            <sch:assert test="contains(/gmi:MI_Metadata/gmd:contentInfo[1]/gmd:MD_FeatureCatalogueDescription[1]/gmd:featureCatalogueCitation[1]/gmd:CI_Citation[1]/gmd:otherCitationDetails[1]/gco:CharacterString[1])"></sch:assert>
        </sch:rule>
    </sch:pattern>-->

 <!-- <sch:pattern id="dateCheck">
    <sch:rule context="/gmi:MI_Metadata/gmd:dateStamp[1]">
        <sch:assert test="starts-with(./gco:Date[1],'2019')">Make sure that the date starts with 2019</sch:assert>
    </sch:rule>
</sch:pattern>

    <sch:pattern id="metadataDateDateCheck">
        <sch:rule context="/gmi:MI_Metadata/gmd:dateStamp[1]/gco:Date[1]">
            <sch:assert test="matches(normalize-space(.gco:Date),'2019')">2019 is missing from the beginning
                of the alternate title</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id="datecheck3">
        <sch:rule context="/gmi:MI_Metadata/gmd:dateStamp[1]">
            <sch:let name="datevalue" value="xs:date(./gco:Date[1])"/>
            <sch:assert test="$datevalue lt  2019"></sch:assert>
          </sch:rule>
    </sch:pattern> -->

<!--  <sch:pattern id="metadataDateCheck">
    <sch:rule context="/gmi:MI_Metadata">
        <sch:let name="currYear" value="string(current-date())"/>
        <sch:let name="year" value="substring-before($currYear,'-')"/>
       
        <sch:let name="metDate" value="substring-before(./gmd:dateStamp[1]/gco:Date[1],'-')"/>
        <sch:let name="metDateA" value="substring-before(./gmd:dateStamp[1]/gco:Date[1],'-')"/>
        <sch:let name="metDateB" value="number($metDateA)"/>
        <sch:assert test="$metDateA != $currYear">Check the metadata date!!!!!! <sch:value-of select="$currYear"/> in not <sch:value-of select="metDate"/> </sch:assert>
        <sch:report test="$metDateA != $currYear">Check the metadata date!!!!!! <sch:value-of select="$year"/> is not 
            <sch:value-of select="metDate"/> . Please correct the date...</sch:report>
    </sch:rule>
</sch:pattern>-->

    <sch:pattern>
        <sch:title>Metadata Date Check</sch:title>
        <sch:rule context="/GPM/Metadata_Reference_Information[1]/Metadata_Date[1]">
            <sch:assert test="contains(.,'2019')">The metadata date does not contain the correct year!!! </sch:assert>
        </sch:rule>
    </sch:pattern>
</sch:schema>
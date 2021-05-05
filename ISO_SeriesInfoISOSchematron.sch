<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
    <sch:ns prefix="dqm" uri="http://standards.iso.org/iso/19157/-2/dqm/1.0"/>
    <sch:ns prefix="cat" uri="http://standards.iso.org/iso/19115/-3/cat/1.0"/>
    <sch:ns prefix="cit" uri="http://standards.iso.org/iso/19115/-3/cit/1.0"/>
    <sch:ns prefix="mcc" uri="http://standards.iso.org/iso/19115/-3/mcc/1.0"/>
    
    <sch:ns prefix="gmi" uri="http://www.isotc211.org/2005/gmi" />
    <sch:ns prefix="gmd"  uri="http://www.isotc211.org/2005/gmd" />
    <sch:ns prefix="gmd" uri="http://www.isotc211.org/2005/gmd"/>
    <sch:ns prefix="gco" uri="http://www.isotc211.org/2005/gco"/>
    <sch:ns prefix="gml" uri="http://www.opengis.net/gml/3.2"/>
    <sch:ns prefix="gts" uri="http://www.isotc211.org/2005/gts"/>
    <sch:ns prefix="gmi" uri="http://www.isotc211.org/2005/gmi"/>
    <sch:ns prefix="xlink" uri="http://www.w3.org/1999/xlink"/>
    <sch:ns prefix="gmx" uri="http://www.isotc211.org/2005/gmx"/>
    
    <sch:let name="KMLKeyword" value="contains(/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:descriptiveKeywords[2]/gmd:MD_Keywords[1]/gmd:keyword[2]/gco:CharacterString[1],'KML')"/>
    <sch:let name="SHPKeyword" value="contains(/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:descriptiveKeywords[2]/gmd:MD_Keywords[1]/gmd:keyword[2]/gco:CharacterString[1],'SHP')"/>
    
    <sch:let name="KMLTitle" value="contains(/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:citation[1]/gmd:CI_Citation[1]/gmd:title[1]/gco:CharacterString[1],'KML')"/>
    <sch:let name="SHPTitle" value="contains(/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:citation[1]/gmd:CI_Citation[1]/gmd:title[1]/gco:CharacterString[1],'Shapefile')"/>
    
    <sch:let name="KMLAB" value="contains(/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:citation[1]/gmd:CI_Citation[1]/gmd:title[1]/gco:CharacterString[1],'KML')"/>
    
    <sch:pattern>
        <!-- Change the attribute to point the element being the context of the assert expression. -->
        <sch:rule context="/gmi:MI_Metadata/gmd:dateStamp[1]/gco:Date[1]">
            <!-- Change the assert expression. -->
            <sch:assert test="contains(.,'2020')">ERR #1: The year mustbe 2020.</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern>
        <sch:rule context="/gmi:MI_Metadata/gmd:distributionInfo[1]/gmd:MD_Distribution[1]/gmd:transferOptions[1]/gmd:MD_DigitalTransferOptions[1]/gmd:onLine[1]/gmd:CI_OnlineResource[1]/gmd:linkage[1]/gmd:URL[1]">
            <sch:assert test="contains(.,'https://www.census.gov/geographies/mapping-files/time-series/geo/cartographic-boundary.html')">ERR #2A: The online linkage must be https://www.census.gov/geographies/mapping-files/time-series/geo/cartographic-boundary.html</sch:assert>
        </sch:rule>
    </sch:pattern>
   
    <sch:pattern>
        <sch:rule context="/gmi:MI_Metadata/gmd:distributionInfo[1]/gmd:MD_Distribution[1]/gmd:transferOptions[2]/gmd:MD_DigitalTransferOptions[1]/gmd:onLine[1]/gmd:CI_OnlineResource[1]/gmd:linkage[1]">
            <sch:assert test="contains(.,'ea')">ERR #2B:The EA file mustcontaoin EA</sch:assert>
            <sch:assert test="contains(.,'2019cb')">ERR #2C:The EA file mustcontaoin  2019cb</sch:assert>
            <sch:assert test="contains(.,'https://meta.geo.census.gov/data/existing/decennial/GEO/CPMB/boundary')">ERR #2D:The EA file mustcontaoin  https://meta.geo.census.gov/data/existing/decennial/GEO/CPMB/boundary</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern>
        <sch:rule context="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:descriptiveKeywords[1]/gmd:MD_Keywords[1]/gmd:keyword[2]/gco:CharacterString[1]">
            <!--   <sch:assert test="$KMLKeyword =false and $SHPKeyword=false" >The keywords must contain either SHP or KML KMLKeyword:<sch:value-of select="$KMLKeyword"/> Shapekeyword:<sch:value-of select="$SHPKeyword"/></sch:assert>
     <sch:assert test="$KMLKeyword = $KMLTitle"> Both the title and the keywords must have KML Title<sch:value-of select="$KMLTitle"/> keyword:<sch:value-of select="$KMLKeyword"/></sch:assert>   -->
            <sch:assert test="contains(.,'SHP') or contains(.,'KML')">ERR #3: The Keywords must contain either Shapefile<sch:value-of select="$SHPTitle"/> or KML<sch:value-of select="$KMLTitle"/></sch:assert>
        </sch:rule>
        
        
    </sch:pattern>
    
    <sch:pattern>
        <sch:rule context="/gmi:MI_Metadata/gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:citation[1]/gmd:CI_Citation[1]/gmd:title[1]/gco:CharacterString[1]">
            <sch:assert test="contains(.,'Shapefile') or contains(.,'KML')">ERR #4: The Title must contain either Shapefile:<sch:value-of select="$SHPTitle"/> or KML:<sch:value-of select="$KMLTitle"/> </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern>
        <sch:title>EX_GeographicBoundingBox</sch:title>
        <sch:rule context="//gmd:EX_GeographicBoundingBox">      
            <sch:assert test="not(gmd:westBoundLongitude/gco:Decimal &lt; -180)">West Bounding Longitude must be -180 or greater</sch:assert>
            <sch:assert test="not(gmd:westBoundLongitude/gco:Decimal &gt; 180)">West Bounding Longitude must be 180 or less</sch:assert>
            <sch:assert test="not(gmd:eastBoundLongitude/gco:Decimal &lt; -180)">eastBoundLongitude must be -180 or greater</sch:assert>
            <sch:assert test="not(gmd:eastBoundLongitude/gco:Decimal &lt; -180)">eastBoundLongitude must be -180 or greater</sch:assert>
            <sch:assert test="not(gmd:southBoundLatitude/gco:Decimal &lt; -90)">southBoundLatitude must be -90 or greater</sch:assert>
            <sch:assert test="not(gmd:southBoundLatitude/gco:Decimal &gt; 90)">southBoundLatitude must be 90 or less</sch:assert>
            <sch:assert test="not(gmd:northBoundLatitude/gco:Decimal &lt; -90)">northBoundLatitude must be -90 or greater</sch:assert>
            <sch:assert test="not(gmd:northBoundLatitude/gco:Decimal &gt; 90)">northBoundLatitude must be 90 or less</sch:assert>
            <!--  -->
            <!-- <assert test="gmd:westBoundLongitude/gco:Decimal &lt; gmd:eastBoundLongitude/gco:Decimal">westBoundLongitude must be less than eastBoundLongitude</assert>
      <assert test="gmd:northBoundLatitude/gco:Decimal &gt; gmd:southBoundLatitude/gco:Decimal">northBoundLatitude must be greater than southBoundLatitude</assert>-->
        </sch:rule>
    </sch:pattern>
</sch:schema>
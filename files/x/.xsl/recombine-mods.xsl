<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.loc.gov/MARC21/slim"
    xmlns:marc="http://www.loc.gov/MARC21/slim"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    exclude-result-prefixes="mods xlink xs xsi" version="2.0">
    
    <xsl:output name="combine" method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
    
    
    <xd:doc>
        <xd:desc>
            <xd:p>This XSLT combines modsCollection XML documents</xd:p>
            <xd:p><xd:b>Instructions:</xd:b>
                <xd:ul>
                    <xd:li>1. Run the fileListGenerator.bat</xd:li>
                    <xd:li>2. Open FileList.txt and collection.xml</xd:li>
                    <xd:li>3. Create a new collections.xml file the XML files contained in filesList.txt</xd:li>
                    <xd:li>4. Run combine-mods.xsl against the new collections.xml</xd:li>
                    <xd:li>5. After the transformation completes, check the filename, and spot check the XML output.</xd:li>
                </xd:ul></xd:p>
        </xd:desc>
    </xd:doc>
   
        <xsl:template match="/">
            <xsl:variable name="fileName" select="replace(base-uri(), '(.*/)(.*)(\.xml)', '$2')"/>
            <xsl:variable name="workingDir" select="substring-before(base-uri(), $fileName)"/>
<!--            <xsl:variable name="agricola" select="string('agricola_IND_Mar23_2-')"/>-->
            <xsl:result-document  exclude-result-prefixes="marc xd xlink xs xsi" 
                method="xml" version="1.0" encoding="UTF-8" indent="yes" 
                format="combine" href="{$workingDir}/recompile/{$fileName}_{position()}.xml"> 
                <marc:collection
                    xmlns="http://www.loc.gov/MARC21/slim"
                    xmlns:marc="http://www.loc.gov/MARC21/slim"
                    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                    xsi:schemaLocation="http://www.loc.gov/MARC21/slim http://www.loc.gov/standards/marcxml/schema/MARC21slim.xsd">
                    <xsl:copy-of copy-namespaces="no" select="collection(collection/doc/@href)//marc:record/>
                </marc:collection>
            </xsl:result-document>
        </xsl:template>
</xsl:stylesheet>
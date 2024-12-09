<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.loc.gov/MARC21/slim"
    xmlns:marc="http://www.loc.gov/MARC21/slim" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:f="http://functions/" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:zs="http://www.loc.gov/zing/srw/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
    xmlns:oclcterms="http://purl.org/oclc/terms/"
    xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:diag="http://www.loc.gov/zing/srw/diagnostic/"
    xsi:schemaLocation="http://www.loc.gov/MARC21/slim http://www.loc.gov/standards/MARC21/slim/mods-3-7.xsd"
    exclude-result-prefixes="dc diag oclcterms zs f xd xsi xs" version="2.0">
    
    
    <xsl:strip-space elements="*"/>
    
    <xsl:output name="originalFile" method="xml" indent="yes" encoding="UTF-8" media-type="text/xml" version="1.0"/>   
    <xsl:output name="archiveFile" method="xml" indent="yes" encoding="UTF-8" media-type="text/xml" version="1.0"/> 
    
    
    <xsl:include href="commons/common.xsl"/>
    <xsl:include href="commons/params.xsl"/>
   
    
    <xd:doc scope="stylesheet" id="OCLC_SRU">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Jul 12, 2021</xd:p>
            <xd:p><xd:b>Author:</xd:b> Carlos.Martinez</xd:p>
            <xd:p><xd:b>Purpose:</xd:b>
                <xd:ul>           
                    <xd:li>To remove the "zing" (or zs) prefixed elements and create individual MARC records</xd:li>
                    <xd:li>The archiveFile records produced from this transformation are direct copies of all the elements within the MARC namespace; beginning with record.</xd:li>
                   <xd:li>The originalFile records produced add the marc prefix to each element making it easier to transform into other formats including MARC21 and MODS</xd:li>
                </xd:ul>
            </xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:include href="NAL-MARC21slimUtils.xsl"/>
   
    <xsl:param name="sruCollection" select="collection('collection-index.xml')"/>
    <xd:doc>
        <xd:desc>sru template </xd:desc>
    </xd:doc>
    <xsl:template match="zs:name" xpath-default-namespace="http://www.loc.gov/zing/srw/"/>
    
    <xd:doc>
        <xd:desc>root template</xd:desc>      
    </xd:doc>
    <xsl:template match="/">  
<!--        <zs:searchRetrieveResponse xmlns:zs="http://www.loc.gov/zing/srw/">-->
            <xsl:for-each select="*//record" xpath-default-namespace="http://www.loc.gov/MARC21/slim">
            <xsl:result-document encoding="UTF-8" indent="yes" method="xml"
                media-type="text/xml" format="originalFile" 
                href="{$workingDir}prefix-{replace($originalFilename, '(.*/)(.*)(\.xml)', '$2')}_{position()}.xml">
                  
                        <xsl:copy-of select="f:add-namespace-prefix(.,'http://www.loc.gov/MARC21/slim', 'marc')"/>
                
            </xsl:result-document>
                </xsl:for-each>
        <!--</zs:searchRetrieveResponse>-->
    </xsl:template>
    
    
  
</xsl:stylesheet>
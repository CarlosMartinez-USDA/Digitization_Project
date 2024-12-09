<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/">
        <Groups>
            <xsl:for-each-group select="/Groups/GroupData" group-by="@ID">
                <xsl:for-each-group select="current-group()" group-by="if(@Key) then @Key else 'no key'">
                    <GroupData>
                        <!-- Copy attributes off the *first* GroupData element in the group -->
                        <xsl:copy-of select="current-group()[1]/@*"/>
                        <!-- Copy ItemData children from *all* GroupData elements in the group -->
                        <xsl:copy-of select="current-group()/ItemData" />
                    </GroupData>
                </xsl:for-each-group>
            </xsl:for-each-group>
        </Groups>
    </xsl:template>
    <xsl:template match="/">
        <Groups>
            <xsl:fo
        </Groups>
    </xsl:template>
</xsl:stylesheet>
</xsl:stylesheet>


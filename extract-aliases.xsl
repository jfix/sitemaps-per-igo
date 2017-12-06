<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://oecd.metastore.ingenta.com/ns/"
    xpath-default-namespace="http://oecd.metastore.ingenta.com/ns/"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:prism="http://prismstandard.org/namespaces/1.2/basic/"
    xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    exclude-result-prefixes="#all"
    version="3.0">
    
    <xsl:output method="text"/>
    <xsl:param name="in.dir" select="'/Users/jakob/Projects/ilibrary?select=*.xml;recurse=yes;on-error=warning'"/>
    <xsl:param name="out.file" select="'out.txt'"/>
    
    <xsl:template match="/">
        <xsl:result-document href="{$out.file}" method="text">
            <xsl:apply-templates mode="extract" select="collection($in.dir)"/>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template match="/*" mode="extract">
        <xsl:variable name="alias" select="alias/@rdf:resource"/>
        <xsl:variable name="igo" select="substring-after(imprint/@rdf:resource, '/')"/>
        <xsl:choose>
            <xsl:when test="$alias and $igo">
                <xsl:value-of select="concat($igo, '&#x9;', $alias, '&#xd;')"/>                
            </xsl:when>
            <xsl:otherwise/>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="*" mode="extract"/>
</xsl:stylesheet>
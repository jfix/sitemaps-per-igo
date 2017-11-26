# sitemaps-per-igo

These are two scripts that should be run one after the other.  The first one, `extract-aliases.xsl`, reads all XML files in a given directory recursively, and extracts the `imprint` and the `alias` from the file. Both items are written to the same output file, separated by a tab character.

The second script, `create-sitemaps.js` is a Javascript file that reads the output file generated above and creates XML sitemap files for each IGO (currently, they are predefined).

The first step takes about 5 minutes, the second less than 30 seconds.

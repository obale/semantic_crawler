# The RDF Dump of the CIA Factbook contains country relevant information. The
# information are maybe deprecated, but for general purpose information that
# never or infrequent change, this source is perfect.
#
# This module encapsulates the access to the underlying RDF files and wrapped
# the most important properties. Not wrapped properties in the namespace of
# factbook could be accessed via the following method:
#
# * link:SemanticCrawler::Factbook::Country::get_factbook_property
module SemanticCrawler::Factbook
end

require_relative 'printer'
require_relative 'importer'

imp = Importer::Engine.new
pri = Printer::Engine.new

imp.start
pri.start

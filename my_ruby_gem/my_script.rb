# frozen_string_literal: true

require_relative 'printer/engine'
require_relative 'importer/engine'

imp = Importer::Engine.new
pri = Printer::Engine.new

imp.start
pri.start

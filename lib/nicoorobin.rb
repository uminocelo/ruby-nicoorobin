require 'pathname'
require_relative 'fleur'

class Nicoorobin
    attr_accessor :path, :ext_from, :dest

    def initialize(path,  dest="own", ext_from="jpg")
        @path = path
        @ext_from = ext_from
        @dest = dest == "own" ? @path : dest
    end

    def call
        directory_path = Pathname.new(@path)
        return nil unless directory_path.directory?

        folders = directory_path.children.filter! { |f| f.directory?  && !f.children.empty?}
        return nil if folders.empty?

        bundles = folders.each_slice(folders.size / 8)
        threads = []
        bundles.each do |bundle|
            threads << Thread.new { perform(bundle) }
        end

        threads.each(&:join)
    end

    private

    def perform(bundler)
        bundler.each do |folder|
            fleur = Fleur.new(folder.to_path, @dest, @ext_from)
            files = Fleur.research(folder.to_path, @ext_from)
            next if files.nil? || files.empty?

            Fleur.build(@dest, @ext_from, folder.basename, files)
        end
    end
end

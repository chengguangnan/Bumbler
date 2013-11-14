module Bumbler
  module Stats
    class << self
      def _print_stats (key)
        Bumbler::Progress.registry.each do |type, items|
          puts "Stats for #{type} items:"

          items.to_a.sort_by! {|n,d| d[key].to_i}.each do |name, info|
            puts '  %s  %s' % [('%d' % info[key].to_i).rjust(8), name]
          end
        end
        
        self
      end

      def memory_delta
        self._print_stats(:memory_delta)
      end

      def gc_objects
        self._print_stats(:gc_objects)
      end

      def tracked_items
        Bumbler::Progress.registry.each do |type, items|
          puts "Stats for #{type} items:"
          
          items.to_a.sort_by! {|n,d| d[:time].to_f}.each do |name, info|
            if info[:time]
              puts '  %s  %s' % [('%.2f' % info[:time]).rjust(8), name]
            else
              puts "  pending:  #{name}"
            end
          end
        end
        
        self
      end
      
      def all_slow_items
        puts "Slow requires:"
        Bumbler::Hooks.slow_requires.to_a.sort_by! {|n,t| t}.each do |name, time|
          puts '  %s  %s' % [('%.2f' % time).rjust(8), name]
        end
        
        self
      end
    end
  end
end

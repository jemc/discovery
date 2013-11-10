
require_relative 'util/udp'
require 'timeout'

module Discovery
  class UDP
    @port  =  0
    @group = "0.0.0.0"
    
    class << self
      attr_accessor :port
      attr_accessor :group
      attr_reader   :thread
    end
    
    def self.new; raise NotImplementedError nil end
    
    # Register a callback to be used in the event of a recognized beacon.
    # Each non-nil response object for each UDP beacon will be yielded to it.
    def self.listen &block
      @blocks ||= []
      (@blocks << block).uniq!
      
      @thread ||= Thread.new do
        loop do
          @discoverables.values.each_with_object(next_beacon) do |blk,beacon|
            obj = blk.call beacon
            @blocks.each do |callback|
              callback.call(obj)
            end unless obj.nil?
          end
        end
      end
    end
    
    # Halt the discovery thread started by listen, 
    # but do not unregister the callback
    def self.halt; @thread.kill; end
    
    # Return the info hash of the next DDDP beacon detected - blocking
    # Optional :timeout keyword argument specifies maximum time to block
    def self.next_beacon timeout:nil
      @udp_rx ||= Util::UDP::RX.new(@group, @port)
      beacon_to_hash(Timeout.timeout(timeout) { @udp_rx.gets })
    end
    
    # Convert the incoming beacon to a Hash containing all necessary info
    # Implement to something nontrivial in the inherited module
    def self.beacon_to_hash beacon
      {beacon:beacon}
    end
    
    # Register a block to be used to convert a recognized
    # beacon info-hash into a response object.
    # The block should accept the info hash as an argument and
    # return the response object or nil if the beacon isn't recognized.
    class << self; attr_reader :discoverables; end
    def self.register cls, &block
      @discoverables ||= {}
      @discoverables[cls] = block
    end
    
  end
end
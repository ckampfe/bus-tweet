require 'spec_helper'

describe TransitHelpers do
  describe ".get" do
    context "for a route" do
      it "gets routes" do
        route = build(:route)
        Hash.stub(:from_xml) { }
        allow_any_instance_of(Object).to receive(:open).and_return { route }

        expect(Hash).to receive(:from_xml).with(route)
        Route.get
      end
    end

    context "for a stop" do
      it "gets stops" do
        stop = build(:stop)
        Hash.stub(:from_xml) { }
        allow_any_instance_of(Object).to receive(:open).and_return { stop }

        expect(Hash).to receive(:from_xml).with(stop)
        Stop.get([{ :key => 'rt', :val => '66' },
                  { :key => 'dir', :val => 'Eastbound' }])
      end
    end

    context "for a direction" do
      it "gets directions" do
        direction = build(:direction)
        Hash.stub(:from_xml) { }
        allow_any_instance_of(Object).to receive(:open).and_return { direction }

        expect(Hash).to receive(:from_xml).with(direction)
        Direction.get([{ :key => 'rt', :val => '37' }])
      end
    end
  end
end

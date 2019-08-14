require 'rails_helper'

RSpec.describe Task, type: :model do
  describe "#toggle_complete!" do
    it "should switch complete to false if it was true" do
      task = Task.create(complete: true)
      task.toggle_complete!
      expect(task.complete).to eq(false)
    end

    it "should switch complete to true if it was false" do
      task = Task.create(complete: false)
      task.toggle_complete!
      expect(task.complete).to eq(true)
    end
  end
  describe '#toggle_favorite!' do
    it "should switch favorite to false if it was true" do
      task = Task.create(favorite: true)
      task.toggle_favorite!
      expect(task.favorite).to eq(false)
    end

    it "should switch favorite to true if it was false" do
      task = Task.create(favorite: false)
      task.toggle_favorite!
      expect(task.favorite).to eq(true)
    end
  end
  describe '#overdue?' do
    it "should return true if deadline is before current time (aka past deadline)" do
      task = Task.create(deadline: Time.now - 10.days)
      expect(task.overdue?).to eq(true)
    end
    it "should return false if deadline is after current time (aka before deadline)" do
      task = Task.create(deadline: Time.now + 10.days)
      expect(task.overdue?).to eq(false)
    end
  end
  describe '#increment_priority!' do
    it "Should increase priority to 6 if it is 5" do
      task = Task.create(priority: 5)
      task.increment_priority!
      expect(task.priority).to eq(6)
    end
    it "Should should keep priority at 10 if priority is 10" do
      task = Task.create(priority: 10)
      task.increment_priority!
      expect(task.priority).to eq(10)
    end
  end
  describe '#decrement_priority!' do
    it "Should decrease priority to 4 if it is 5" do
      task = Task.create(priority: 5)
      task.decrement_priority!
      expect(task.priority).to eq(4)
    end
    it "Should should keep priority at 1 if priority is 1" do
      task = Task.create(priority: 1)
      task.decrement_priority!
      expect(task.priority).to eq(1)
    end
  end
  describe '#snooze_hour!' do
    it "Should push the deadline one hour from time created" do
      created_time = Time.now
      task = Task.create(deadline: created_time)
      task.snooze_hour!
      expect(task.deadline).to eq(created_time + 1.hour)
    end
  end
end

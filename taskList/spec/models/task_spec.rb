require 'rails_helper'

RSpec.describe Task, type: :model do
  it 'has a title and description' do
    task = Task.new(title: 'Clean car', description: 'Vaccuum')
    expect(task.save).to eq true
    t2 = Task.find_by_title('Clean car')
    expect(t2.title).to eq 'Clean car'
    expect(t2.description).to eq 'Vaccuum'
  end

  it "has task records" do
    task2 = Task.new(title: 'Dishes', description: 'Load Dish Washer')
    expect(task2.save).to eq true
    task3 = Task.new(title: 'Laundry', description: 'Wash Whites')
    expect(task3.save).to eq true
    expect(Task.all).to match_array [task2,task3]
  end


end

# frozen_string_literal: true

require "rails_helper"

RSpec.describe MealPlanAssistant::Conversation do
  let(:user) { create(:user) }
  let(:prep_day) { Date.new(2026, 11, 15) }
  let(:chili) { create(:recipe, user: user, title: "Black Bean Chili") }
  let(:conversation) { described_class.new(user: user, prep_day: prep_day) }
  let(:reply) do
    MealPlanAssistant::Reply.new(
      message: "Cozy ideas.",
      suggestions: [MealPlanAssistant::Suggestion.new(recipe: chili, reason: "Warming.")],
      history: [{role: "user", content: "cozy"}, {role: "assistant", content: "{}"}]
    )
  end

  before { allow(Rails).to receive(:cache).and_return(ActiveSupport::Cache::MemoryStore.new) }

  it "starts empty" do
    expect(conversation.history).to eq([])
    expect(conversation.turns).to eq([])
  end

  it "persists history and turns across instances" do
    conversation.append(user_message: "Something cozy", reply: reply)

    reloaded = described_class.new(user: user, prep_day: prep_day)
    expect(reloaded.history).to eq([{"role" => "user", "content" => "cozy"}, {"role" => "assistant", "content" => "{}"}])

    turn = reloaded.turns.sole
    expect(turn.user_message).to eq("Something cozy")
    expect(turn.message).to eq("Cozy ideas.")
    expect(turn.suggestions.map(&:recipe)).to eq([chili])
    expect(turn.suggestions.first.reason).to eq("Warming.")
  end

  it "returns the appended turn" do
    turn = conversation.append(user_message: "Something cozy", reply: reply)

    expect(turn.user_message).to eq("Something cozy")
    expect(turn.suggestions.map(&:recipe)).to eq([chili])
  end

  it "keeps a separate conversation per prep day and per user" do
    conversation.append(user_message: "Something cozy", reply: reply)

    expect(described_class.new(user: user, prep_day: prep_day + 7).turns).to be_empty
    expect(described_class.new(user: create(:user), prep_day: prep_day).turns).to be_empty
  end

  it "skips suggested recipes that are no longer active" do
    conversation.append(user_message: "Something cozy", reply: reply)
    chili.update!(status: :archived)

    expect(described_class.new(user: user, prep_day: prep_day).turns.sole.suggestions).to be_empty
  end

  it "clears the conversation" do
    conversation.append(user_message: "Something cozy", reply: reply)
    conversation.clear

    expect(conversation.turns).to be_empty
    expect(described_class.new(user: user, prep_day: prep_day).history).to be_empty
  end
end

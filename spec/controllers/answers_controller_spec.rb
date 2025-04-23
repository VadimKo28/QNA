require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  describe "POST #create" do
  let(:question) { create(:question) }
    context "valid attribute answer" do
      it "save answer" do
        expect { post :create, params: { question_id: question, answer: attributes_for(:answer) } }.to change(Answer, :count).by(1)
      end

      it "redirect to show question" do
        post :create, params: { question_id: question, answer: attributes_for(:answer) }
        expect(response).to redirect_to assigns(:question)
      end
    end

    context "invalid attribute answer" do
      it "does not save anwser" do
        expect { post :create, params: { question_id: question, answer: { body: nil } } }.to_not change(Answer, :count)
      end

      it "render new view" do
        post :create, params: { question_id: question, answer: { body: nil } }
        expect(response).to render_template :new
      end
    end
  end
end

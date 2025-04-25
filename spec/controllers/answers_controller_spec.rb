require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  describe "POST #create" do
    let(:user) { create(:user) }
    let(:question) { create(:question) }

    before { login(user) }

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

      it "render question show view" do
        post :create, params: { question_id: question, answer: { body: nil } }
        expect(response).to render_template 'questions/show'
      end
    end
  end
end

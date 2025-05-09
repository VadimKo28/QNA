require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }

  describe "POST #create" do
    before { login(user) }

    context "valid attribute answer" do
      it "save answer" do
        expect { post :create, params: { user: user, question_id: question, answer: attributes_for(:answer) } }.to change(Answer, :count).by(1)
      end

      it "redirect to show question" do
        post :create, params: { user_id: user, question_id: question, answer: attributes_for(:answer) }
        expect(response).to redirect_to assigns(:question)
      end
    end

    context "invalid attribute answer" do
      it "does not save anwser" do
        expect { post :create, params: { question_id: question, answer: { body: nil } } }.to_not change(Answer, :count)
      end

      it "render question show view" do
        post :create, params: { question_id: question, answer: { body: nil } }, format: :turbo_stream
        expect(response).to render_template :create
      end
    end
  end

  describe 'PATCH #update' do
    let!(:answer) { create(:answer, question: question, user: user) }

    before { login(user) }

    context 'with valid attributes' do
      it 'changes answer attributes' do
        patch :update, params: { id: answer, answer: { body: 'new body' } }, format: :turbo_stream
        answer.reload
        expect(answer.body).to eq 'new body'
      end
    end


    context 'with invalid attributes' do
      it 'does not changes answer body' do
        expect do
          patch :update, params: { id: answer, answer: { body: nil } }, format: :turbo_stream
        end.to_not change(answer, :body)
      end
    end
  end
end

require 'rails_helper'

RSpec.describe User, type: :model do
  # ユーザID,メール,パスワードがあれば有効な状態であること
  it "is valid with a email and password" do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end
  # メールがなければ無効な状態であること
  it "is invalid without a email" do
    user = FactoryBot.build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("を入力してください")    
  end
  # 重複したメールなら無効な状態であること
  it "is invalid with a duplicate email" do
    User.create(
      email: "kotaro@gmail.com",
      password: "iamkotaroyamada"
    )
    user = User.new(
      email: "kotaro@gmail.com",
      password: "iamjiroyamada"
    )
    user.valid?
    expect(user.errors[:email]).to include("はすでに存在します")
  end
  # 30文字以上のユーザ名は無効であること
  it "is invalid with username with more than 30 characters" do
    user = FactoryBot.build(:user, username: "1234567890123456789012345678901")
    user.valid?
    expect(user.errors[:username]).to include("は30文字以内で入力してください")
  end

  # フォロー・アンフォローを行う
  describe "can follow or unfollow the user" do
    before do
      @user1 = User.create(
        email: "kotaro@gmail.com",
        password: "iamkotaroyamada"        
      )

      @user2 = User.create(
        email: "jiro@gmail.com",
        password: "iamjiroyamada"
      )
    end

    # フォローしているとき
    context "when user1 follow user2" do
      before do
        @user1.follow(@user2.id)
      end

      # 既にフォローしているユーザをフォローできない
      it "user1 cannot follow user2" do
        flw = @user1.follow(@user2.id)
        flw.valid?
        expect(flw.errors[:followed_id]).to include("はすでに存在します")
      end
      # フォロー確認でtrueとなる
      it "result of following check is true" do
        flw = @user1.following?(@user2)
        expect(flw).to eq true
      end      
      # アンフォローできる
      it "user1 can unfollow user2" do
        flw = @user1.unfollow(@user2.id)
        expect(flw).to be_valid
      end
    end

    # フォローしていないとき
    context "when user1 does not follow user2" do
      # フォローできる
      it "user1 can follow user2" do
        flw = @user1.follow(@user2.id)
        flw.valid?
        expect(flw).to be_valid
      end
      # フォロー確認でfalseとなる
      it "result of following check is false" do
        flw = @user1.following?(@user2)
        expect(flw).to eq false
      end
    end

  end

end

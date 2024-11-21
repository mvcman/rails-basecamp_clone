import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["userIds", "userSearch", "userChips"]
  connect() {
    console.log("connected assigned user......");
    this.userSearchTarget.addEventListener("input", this.searchUsers.bind(this));
    console.log("user ids ", this.userIdsTarget.value.split(","));
    const selectedUsers = this.userIdsTarget.value.split(",");
    this.selectedUsers = new Set();
    if (selectedUsers.length > 0) {
      this.searchSelectedUsers(selectedUsers);
    } else {
      this.updateChips()
    }
    // this.selectedUsers = new Set(this.userIdsTarget.value.split(",").filter(id => id))
    
    // this.selectedUsers = [];
    
  }

  async searchSelectedUsers(users) {
    console.log("in search selected users!");
    const response = await fetch(`/selected_users?ids=${users}`);
    console.log("resp ", response);
    const users2 = await response.json()
    console.log("json data ", users2);
    let my_users = [];
    users2.map(u => {
      my_users.push({ id: u.id, name: u.profile.first_name + " " + u.profile.last_name, email: u.email });
    });
    this.selectedUsers = new Set(my_users);
    this.updateChips()
  }

  userExist(user, set) {
    for (let item of set) {
      if (item.id == user.id) {
        console.log("user exist!");
        return true;
      }
    }
    return false;
  }

  async searchUsers(event) {
    const query = event.target.value
    if (query.length < 2) return

    const response = await fetch(`/users?q=${query}`)
    console.log("resp ", response);
    const users = await response.json()
    console.log("json data ", users);

    this.showUserList(users.filter(u => !this.userExist(u, this.selectedUsers)));
  }

  showUserList(users) {
    const list = document.getElementById("user-list");
    list.innerHTML = "";
    if (users.length == 0) {
      const item = document.createElement("li")
      item.textContent = "No user found";
      item.addEventListener("click", this.removeList.bind(this));
      list.appendChild(item);
    } else {
      users.forEach(user => {
        console.log("user ", user, user.profile);
        const item = document.createElement("li")
        item.textContent = user.profile.first_name + " " + user.profile.last_name;
        item.dataset.user = `${user.id};${user.profile.first_name + " " + user.profile.last_name};${user.email}`;
        item.addEventListener("click", this.addUser.bind(this));
        list.appendChild(item);
      });
    }
    this.userSearchTarget.nextElementSibling?.remove()
    this.userSearchTarget.insertAdjacentElement("afterend", list)
  }

  addUser(event) {
    let user_data = event.target.dataset.user.split(";");
    const user = { id: user_data[0], name: user_data[1], email: user_data[2] };
    if (!this.selectedUsers.has(user)) {
      this.selectedUsers.add(user)
      this.updateChips()
    }
    document.getElementById("user-list").innerHTML = "";
    this.userSearchTarget.value = "";
  }

  removeUser(user) {
    this.selectedUsers.delete(user);
    this.updateChips()
  }

  removeList() {
    const list = document.getElementById("user-list");
    list.innerHTML = "";
    this.userSearchTarget.value = "";
  }

  updateChips() {
    this.userChipsTarget.innerHTML = "";
    console.log("selected users ", this.selectedUsers);
    this.selectedUsers.forEach(user => {
      const chip = document.createElement("div")
      chip.classList.add("chip")
      chip.textContent = user.name;
      chip.addEventListener("click", () => this.removeUser(user));
      this.userChipsTarget.appendChild(chip)
    })
    this.userIdsTarget.value = Array.from(this.selectedUsers).map(user => user.id);
  }
}



$(document).ready(function() {


	// jquery function to change type of password field
	$.fn.showPassword = (inputFieldId, isPasswordVisible) => {
		const inputField = $(inputFieldId);

		inputField.attr("type", isPasswordVisible ? "text" : "password");

		$("#open").toggle(isPasswordVisible)
		$("#close").toggle(!isPasswordVisible);
	}

	$("#open,#close").click(function() {

		const isPasswordVisible = $(this).attr("id") === "close";



		$.fn.showPassword("#userPassword", isPasswordVisible);

	})
	// end jquery function to change type of password field

	//profile edit and show

	let btnstate = false;
	$("#edit_btn").click(function() {


		if (btnstate == false) {

			$("#user_detail").hide();
			$("#user_edit").show();
			$(this).text("BACK");
			btnstate = true;
		} else {
			$("#user_detail").show();
			$("#user_edit").hide();
			$(this).text("EDIT");
			btnstate = false;
		}

	});

	//end profile edit and show

	// password compare validation
	$("#userPassword1,#userPassword2").on("input", function() {
		checkPasswordMatch();
	});
	// end password compare validation

	//update profile
	$("#updateuprofile").on("submit", function(event) {

		event.preventDefault();
		$("#btnpprosave").hide()
		$("#spnpproloader").show()
		let formData = new FormData(this);

		$.ajax({

			url: "UpdateProfile",
			type: "POST",
			data: formData,
			success: function(data) {

				if (data.status.trim() === "success") {
					Swal.fire({
						title: data.status.trim(),
						text: data.message.trim(),
						icon: data.status.trim(),
						draggable: true,
						allowOutsideClick: false
					}).then((result) => {
						if (result.isConfirmed) {
							window.location.reload();
						}
					});
				}
				else if (data.status.trim() === "error") {
					Swal.fire({
						title: "Error!",
						text: data.message.trim(),
						icon: data.status.trim(),
						confirmButtonText: "Retry",
						allowOutsideClick: false
					}).then((result) => {
						if (result.isConfirmed) {
							$("#btnpprosave").show()
							$("#spnpproloader").hide()
						}
					});
				}
			},

			error: function(error) {

				Swal.fire({
					icon: "error",
					title: "Oops " + error + " !",
					text: "Something went wrong!",
					allowOutsideClick: false
				}).then((result) => {
					if (result.isConfirmed) {
						$("#btnpprosave").show()
						$("#spnpproloader").hide()
					}
				});

			},
			processData: false,
			contentType: false

		});
	});

	$("#changePassword").on("submit", function(event) {

		event.preventDefault();
		$("#btnchpass").hide()
		$("#spchloader").show()
		let formData = new FormData(this);

		$.ajax({

			url: "UpdatePassword",
			type: "POST",
			data: formData,
			success: function(data) {

				if (data.status.trim() === "success") {
					Swal.fire({
						title: data.status.trim(),
						text: data.message.trim(),
						icon: data.status.trim(),
						draggable: true,
						allowOutsideClick: false
					}).then((result) => {
						if (result.isConfirmed) {
							window.location.reload();
						}
					});
				}
				else if (data.status.trim() === "error") {
					Swal.fire({
						title: "Error!",
						text: data.message.trim(),
						icon: data.status.trim(),
						confirmButtonText: "Retry",
						allowOutsideClick: false
					}).then((result) => {
						if (result.isConfirmed) {
							$("#btnchpass").show()
							$("#spchloader").hide()
						}
					});
				}
			},
			error: function(error) {

				Swal.fire({
					icon: "error",
					title: "Oops " + error + " !",
					text: "Something went wrong!",
					allowOutsideClick: false
				}).then((result) => {
					if (result.isConfirmed) {
						$("#btnchpass").show()
						$("#spchloader").hide()
					}
				});

			},
			processData: false,
			contentType: false

		});
	});
	//end update profile

	// on submit event verify data save or not
	$("#user_form_id").on("submit", function(event) {
		event.preventDefault();

		$("#form_refresh").show();
		$("#form_btn").hide();

		let formdata = new FormData(this);

		// setTimeout function to delay registration for 1sec
		setTimeout(function() {

			$.ajax({
				url: "RegisterServlet",
				type: "POST",
				data: formdata,
				success: function(data) {
					if (data.status.trim() === "success") {
						Swal.fire({
							title: data.message,
							text: "we are redirecting you to login page....",
							icon: data.status.trim(),
							draggable: true,
							allowOutsideClick: false
						}).then((result) => {
							if (result.isConfirmed) {
								window.location = data.redirect.trim();
							}
						});
					}
					else if (data.status.trim() === "badwarn") {
						Swal.fire({
							title: "Warning!",
							text: data.message.trim(),
							icon: "warning",
							confirmButtonText: "OK",
							allowOutsideClick: false
						}).then((result) => {
							if (result.isConfirmed) {
								$("#form_refresh").hide();
								$("#form_btn").show();
							}
						});
					}
					else {
						Swal.fire({
							title: "Error!",
							text: "Registration failed. Please try again.",
							icon: "error",
							confirmButtonText: "Retry",
							allowOutsideClick: false
						}).then((result) => {
							if (result.isConfirmed) {
								$("#form_refresh").hide();
								$("#form_btn").show();
							}
						});
					}
				},
				error: function(error) {
					Swal.fire({
						icon: "error",
						title: "Oops " + error + " !",
						text: "Something went wrong!",
						allowOutsideClick: false
					}).then((result) => {
						if (result.isConfirmed) {
							$("#form_refresh").hide();
							$("#form_btn").show();
						}
					});
				},
				processData: false,
				contentType: false
			})

		}, 1000)
	});
	// end on submit event verify data save or not

	// start to handle blog-post form...

	$("#add-post-form").on("submit", function(e) {

		e.preventDefault();
		$("#spostbtn").prop("disabled", true)
		$("#spostloader").show()
		let formdata = new FormData(this);

		$.ajax({

			url: "AddPostServlet",
			type: "post",
			data: formdata,
			success: function(data) {
				if (data.status.trim() === "success") {
					Swal.fire({
						title: data.status.trim(),
						text: data.message.trim(),
						icon: data.status.trim(),
						draggable: true,
						allowOutsideClick: false
					}).then((result) => {
						if (result.isConfirmed) {
							$("#add-post-form")[0].reset();
							window.location.reload();
						}
					});
				}
				else if (data.status.trim() === "error") {
					Swal.fire({
						title: data.status.trim(),
						text: data.message.trim(),
						icon: data.status.trim(),
						confirmButtonText: "OK",
						allowOutsideClick: false
					}).then((result) => {
						if (result.isConfirmed) {
							$("#spostbtn").prop("disabled", false)
							$("#spostloader").hide()
						}
					});
				}
			},
			error: function(error) {
				Swal.fire({
					icon: "error",
					title: "Oops " + error + " !",
					text: "Something went wrong!",
					allowOutsideClick: false
				}).then((result) => {
					if (result.isConfirmed) {
						$("#spostbtn").prop("disabled", false)
						$("#spostloader").hide()
					}
				});
			},
			contentType: false,
			processData: false
		});

	});

	// end handle blog-post form...

	// start load function to display post from other file

	let alllinksref = $(".c-link")[0];
	loadPost(0, alllinksref);

	// end load function to display post from other file

	loadComments()

})

// start make post like
temp = 0;
function makePostLike(event, isliked, pid, uid) {

	event.preventDefault();

	if (temp == 0 && !isliked) {

		d = {
			pid: pid,
			uid: uid,
			operation: "Like"
		}

		$.ajax({
			url: "AddLikes",
			data: d,
			type: "post",
			success: function(data) {
				$("#likedis").addClass("ri-thumb-up-fill")
				$("#likedis").removeClass("ri-thumb-up-line");
				$("#likedis" + pid).addClass("ri-thumb-up-fill")
				$("#likedis" + pid).removeClass("ri-thumb-up-line");
			},
			error: function(error) {
				console.log(error)
			}
		})
		temp = 1;
	}
	else {

		d = {
			pid: pid,
			uid: uid,
			operation: "DisLike"
		}

		$.ajax({
			url: "DisLikes",
			data: d,
			type: "post",
			success: function(data) {
				$("#likedis").removeClass("ri-thumb-up-fill");
				$("#likedis").addClass("ri-thumb-up-line")
				$("#likedis" + pid).removeClass("ri-thumb-up-fill");
				$("#likedis" + pid).addClass("ri-thumb-up-line")
			},
			error: function(error) {
				console.log(error);
			}
		})
		temp = 0;
	}
}
// end make post like	

//ispasswordmatches function
function checkPasswordMatch() {

	let password = $("#userPassword1").val();
	let confirmPassword = $("#userPassword2").val();
	let massage = $("#massage");

	if (password === confirmPassword) {
		massage.text("Password match.").css('color', '#14A44D');
		return true;
	}
	else {
		massage.text("Password don't match...!").css('color', '#ffcc00');
		return false;
	}
}
//end ispasswordmatches function


// start display post from other file

function loadPost(cid, clinks) {
	$("#postLoader").hide();
	$(".c-link").removeClass("active");
	$.ajax({
		url: "post",
		data: { catid: cid },
		success: function(data) {
			$("#postContent").html(data);
			$(clinks).addClass("active");
		}
	});
}
// end display post from other file


// start enable tab key for text area

function enabledTabKey(textarea) {

	textarea.addEventListener("keydown", function(event) {
		if (event.key === "Tab") {
			event.preventDefault(); // Prevent default tab key behavior

			// Get the current cursor position
			const start = this.selectionStart;
			const end = this.selectionEnd;

			// Insert a tab character at the cursor position
			this.value = this.value.substring(0, start) + "\t" + this.value.substring(end);

			// Move the cursor after the inserted tab
			this.selectionStart = this.selectionEnd = start + 1;
		}
	});

}

// end enable tab key for text area


// start load comments

function loadComments(epid) {
	$.ajax({
		url: "comment",
		type:"POST",
		data:{pid:epid},
		success: function(data) {
			$("#msgcontent").html(data)
		}

	});

}

// end load comments

// start toggle chatbox

function toggleChatBox(event) {
	event.preventDefault();
	$("#msgbox").slideToggle();
}

// end toggle chatbox 


// start send comment
function sendComment(event, pid, uid) {
	event.preventDefault();

	// Get and trim the comment message
	let commentmsg = $("#msgcomm").val().trim();

	// Ensure comment is not empty before sending
	if (commentmsg === "") {
		Swal.fire({
			title: "Warning",
			text: "comment box cannot be empty",
			icon: "warning",
			confirmButtonText: "Retry",
			allowOutsideClick: false
		})
		return;
	}

	// Send the comment via AJAX
	$.ajax({
		url: "CommentServlet",
		type: "POST",
		data: { msg: commentmsg, pid: pid, uid: uid },
		success: function(data) {
			if (data.status.trim() === "success") {
				// Reload comments after successful submission
				loadComments(pid);
				$("#msgcomm").val(""); // Clear the input after submitting
			} else {
				alert("Failed to submit comment. Please try again.");
			}
		},
		error: function(xhr, status, error) {
			console.error("Error:", error);
			alert("An error occurred while submitting your comment. Please try again.");
		}
	});
}


// end send comment

/*
<script>

	const form = document.querySelector("#user_form_id");

	form.addEventListener("submit", async function (event) {
		event.preventDefault();

	const refresh = document.querySelector("#form_refresh");
	const formbtn = document.querySelector("#form_btn");

	refresh.style.display = "block";
	formbtn.style.display = "none";

	let formdata = new FormData(form);

	try {

						const response = await fetch("RegisterServlet", {
		method: "POST",
	body: formdata,
						})

	const data = await response.text();

	console.log(data.toString());

	if (data.trim() === "done") {
		Swal.fire({
			title: data,
			text: "we are redirecting you to login page....",
			icon: "success",
			draggable: true
		}).then((result) => {
			if (result.isConfirmed) {
				window.location = "login.jsp";
			}
		})
	}
	else if (data.trim() === "boxnot") {
		Swal.fire({
			title: "Warning!",
			text: "Please agree to the terms and conditions.",
			icon: "warning",
			confirmButtonText: "OK"
		});
						}
	else {
		Swal.fire({
			title: "Error!",
			text: "Registration failed. Please try again.",
			icon: "error",
			confirmButtonText: "Retry"
		});
						}
	refresh.style.display = "none";
	formbtn.style.display = "block";

					} catch (error) {
		Swal.fire({
			icon: "error",
			title: "Oops " + error + " !",
			text: "Something went wrong!",
		});
					}

				})

</script> */

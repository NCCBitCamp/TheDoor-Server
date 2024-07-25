const patternbox = document.querySelector(".patternbox");
        const patternbox1 = document.querySelector("#patternbox1");
        const patternbox2 = document.querySelector("#patternbox2");
        const patternbox3 = document.querySelector("#patternbox3");
        const patternbox4 = document.querySelector("#patternbox4");
        const clearbtn = document.querySelector(".clearbtn");
        // const modalbtn = document.querySelector("#modalbtn");

        let cnt1 = Math.floor(Math.random() * 4);
        let cnt2 = Math.floor(Math.random() * 4);
        let cnt3 = Math.floor(Math.random() * 4);
        let cnt4 = Math.floor(Math.random() * 3); // <= 1/16확률로 한번에 끝나지 않게

        patternbox1.addEventListener("click", (e) => {
            cnt1++;

            patternbox1.style.backgroundImage = `url('imgForClue${cnt1}.png')`
            patternbox2.style.backgroundRepeat = 'no-repeat';
            patternbox1.style.backgroundSize = 'cover';

            if (cnt1 === 4) {
                cnt1 = 0;
            }
        });
        patternbox2.addEventListener("click", (e) => {
            cnt2++;

            patternbox2.style.backgroundImage = `url('imgForClue${cnt2}.png')`;
            patternbox2.style.backgroundRepeat = 'no-repeat';
            patternbox2.style.backgroundSize = 'cover';

            if (cnt2 === 4) {
                cnt2 = 0;
            }
        });
        patternbox3.addEventListener("click", (e) => {
            cnt3++;

            patternbox3.style.backgroundImage = `url('imgForClue${cnt3}.png')`
            patternbox3.style.backgroundRepeat = 'no-repeat';
            patternbox3.style.backgroundSize = 'cover';

            if (cnt3 === 4) {
                cnt3 = 0;
            }
        });
        patternbox4.addEventListener("click", (e) => {
            cnt4++;

            patternbox4.style.backgroundImage = `url('imgForClue${cnt4}.png')`
            patternbox4.style.backgroundRepeat = 'no-repeat';
            patternbox4.style.backgroundSize = 'cover';

            if (cnt4 === 4) {
                cnt4 = 0;
            }
        });

        clearbtn.addEventListener("click", (e) => {
            // 마지막번째 사진은 0이여야 열림

            clearbtn.classList.add("active");
            setTimeout(() => { // removing active class after 150 ms from the clicked key element
                clearbtn.classList.remove("active");
            }, 150);

            if (cnt1 === 3 && cnt2 === 2 && cnt3 === 1 && cnt4 === 0) {
                alert("서랍이 열렸습니다.");
                // 인벤토리에 깨진액자 추가
                let inventory = JSON.parse(localStorage.getItem('inventory')) || [];
                const itemExists = inventory.includes('/static/images/theHostel/useritem/손목시계.png');
                if (!itemExists) {
                    inventory.push('/static/images/theHostel/useritem/손목시계.png');
                    localStorage.setItem('inventory', JSON.stringify(inventory));
                }

                // 메시지 표시 후 페이지 이동
                setTimeout(function() {
                    alert('시계를 얻었습니다.');
                    window.location.href = '/theHostel/right-wall.do'; // 돌아갈 페이지로 이동
                }, 500);
            } else {
                alert("틀렸습니다.");
            }
        });

        document.getElementById('back-button').addEventListener('click', function() {
            window.location.href = '/theHostel/right-wall.do'; // 돌아갈 페이지로 이동
        });
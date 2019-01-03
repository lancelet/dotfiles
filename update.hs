#!/usr/bin/env cabal
{- cabal:
build-depends:
    base   ^>= 4.12
  , text   ^>= 1.2
  , turtle ^>= 1.5
-}

{-# LANGUAGE OverloadedStrings #-}

import           Control.Monad (unless, when)
import           Data.Text     (Text)
import qualified Data.Text     as T
import           Turtle        (ExitCode, FilePath, Shell, directory, empty,
                                home, inshell, isDirectory, isSymbolicLink,
                                liftIO, mktree, pushd, pwd, rm, rmtree, sh,
                                shell, stat, symlink, testdir, testfile,
                                testpath, toText, (.&&.), (.||.), (</>))

import           Prelude       hiding (FilePath)

main :: IO ()
main = do
    putStrLn "Hello world!"
    sh everything

everything :: Shell ()
everything = do
    linkDotFiles
    nix

    -- After installing omf, need to manually do:
    --  cd ~/.config/oh-my-fish
    --  ./bin/install --offline --yes
    --  omf install bobthefish
    --  omf theme bobthefish
    omf

-- | Force a symbolic link, removing an existing file if present.
forceLink :: FilePath -> FilePath -> Shell ()
forceLink source dest = do
    -- if the file exists then remove it
    exists <- testfile dest
    when exists (rm dest)
    -- set up the new symbolic link
    symlink source dest

-- | Force removal of a file.
rmtreef :: FilePath -> Shell ()
rmtreef path = do
    exists <- testpath path
    when exists (rmtree path)

-------------------------------------------------------------------------------
-- Actual dotfiles
-------------------------------------------------------------------------------

data DotFile
  = DotFile
    { inRepo :: FilePath
    , inDir  :: FilePath
    }

dotFiles :: [DotFile]
dotFiles
  = [ DotFile "config.nix" ".nixpkgs/config.nix"
    , DotFile "emacs-config.org" ".emacs.d/config.org"
    , DotFile "init.el" ".emacs.d/init.el"
    , DotFile "profile" ".profile"
    , DotFile "config.fish" ".config/fish/config.fish"
    ]

-- | Link dotfiles.
linkDotFiles :: Shell ()
linkDotFiles = sequence_ $ linkDotFile <$> dotFiles

-- | Link a single dotfile.
linkDotFile :: DotFile -> Shell ()
linkDotFile dotFile = do
    curDir <- pwd
    homeDir <- home
    let
        sourceFile = curDir </> (inRepo dotFile)
        targetDir = homeDir </> (directory . inDir $ dotFile)
        targetFile = homeDir </> (inDir dotFile)
    mktree targetDir
    forceLink sourceFile targetFile
    pure ()

-- | Unlink any installed dotfiles.
unLinkDotFiles :: Shell ()
unLinkDotFiles = sequence_ $ unlinkDotFile <$> dotFiles

-- | Unlink a single dotfile.
unlinkDotFile :: DotFile -> Shell ()
unlinkDotFile dotFile = do
    homeDir <- home
    let
        targetFile = homeDir </> (inDir dotFile)
    exists <- testfile targetFile
    when exists (rm targetFile)

-------------------------------------------------------------------------------
-- Oh My Fish
-------------------------------------------------------------------------------

omfDir :: Shell FilePath
omfDir = do
  homeDir <- home
  pure (homeDir </> ".config" </> "oh-my-fish")

omf :: Shell ()
omf = do
  installed <- omfInstalled
  if installed then updateOmf else installOmf
  pure ()

omfInstalled :: Shell Bool
omfInstalled = omfDir >>= testdir

installOmf :: Shell ()
installOmf = do
  homeDir <- home
  let d = homeDir </> ".config"
  mktree d
  pushd d >> inshell "git clone https://github.com/oh-my-fish/oh-my-fish" empty
  pure ()

updateOmf :: Shell ()
updateOmf = omfDir >>= pushd >> inshell "git checkout master" empty >> pure ()

-------------------------------------------------------------------------------
-- Nix
-------------------------------------------------------------------------------

-- | Check if Nix is installed already.
nixInstalled :: Shell Bool
nixInstalled = testdir "/nix"

inNix :: Text -> Shell ExitCode
inNix cmd = do
    let fullCmd = T.concat [ "source ~/.nix-profile/etc/profile.d/nix.sh && ", cmd ]
    shell fullCmd empty

-- | Nix cycle.
nix :: Shell ()
nix = do
    installed <- nixInstalled
    unless installed $ do
        -- The nix installer will complain if the dotfiles reference Nix,
        -- so we have to un-link them temporarily.
        unLinkDotFiles
        homeDir <- home
        rmtreef (homeDir </> ".nix-channels")
        rmtreef (homeDir </> ".nix-defexpr")
        rmtreef (homeDir </> ".nix-profile")
        rmtreef (homeDir </> ".nixpkgs")
        installNix
        linkDotFiles
    inNix "nix-channel --remove nixpkgs"
    inNix "nix-channel --add https://nixos.org/channels/nixpkgs-18.09-darwin nixpkgs"
    inNix "nix-channel --update"
    inNix "nix-env -iA nixpkgs.coreEnv"
    pure ()

-- | Install Nix.
installNix :: Shell ()
installNix = do
    inshell "sh" (inshell "curl https://nixos.org/nix/install" empty)
    pure ()

